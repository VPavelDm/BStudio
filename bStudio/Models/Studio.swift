//
//  Studio.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

class Studio: ObservableObject {
    private let repository = StudioRepository()
    var services: [Service] { Service.allCases }
    var vocalRecordingTypes: [VocalRecordingType] { VocalRecordingType.allCases }
    @Published var reservations: [Reservation] = []
    @Published var authors: [Author] = []
    private var _workTimes: [String] = []
    private var unavailableDateRanges: [Range<Date>] {
        reservations.map { $0.timeInterval }
    }
    var isStudioLoaded: Bool { !authors.isEmpty }
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("H:mm")
        return dateFormatter
    }()
    
    // MARK: - Intents
    func getAuthors(for service: Service) -> [Author] {
        authors.filter { $0.services.contains(service) }
    }
    func loadStudio() {
        repository.loadStudio { [weak self] response in
            switch response {
            case let .success((authors, workTimes, reservations)):
                self?.authors = authors
                self?._workTimes = workTimes
                self?.reservations = reservations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeReservation(params: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        repository.makeReservation(params: params) { [weak self] result in
            switch result {
            case .success(let (authors, workTimes, reservations)):
                self?.reservations = reservations
                self?.authors = authors
                self?._workTimes = workTimes
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func workTimes(for date: Date) -> [WorkTime] {
        var workTimes = _workTimes
            .map { time in
                DateMapper(time: time, date: date).serverTime
            }
            .map { time in
                Date(timeIntervalSince1970: time)
            }
            .map { time in
                WorkTime(text: dateFormatter.string(from: time),
                         isEnabled: !unavailableDateRanges.contains(where: { $0.contains(time) }) && Date() < time)
            }
        
        guard workTimes.count > 1 else {
            return workTimes
        }
        
        workTimes[0].isEnabled = workTimes[0].isEnabled && workTimes[1].isEnabled
        for index in 1..<workTimes.count-1 {
            if !workTimes[index-1].isEnabled && !workTimes[index+1].isEnabled {
                workTimes[index].isEnabled = false
            }
        }
        workTimes[workTimes.count-1].isEnabled = workTimes[workTimes.count-1].isEnabled && workTimes[workTimes.count-2].isEnabled
        return workTimes
    }
    func isDateRangeContinuous(startTime: String, endTime: String, date: Date) -> Bool {
        let startTime = DateMapper(time: startTime, date: date).serverTime
        let startDate = Date(timeIntervalSince1970: startTime)
        let endTime = DateMapper(time: endTime, date: date).serverTime
        let endDate = Date(timeIntervalSince1970: endTime)
        
        guard startDate < endDate else { return true }
        
        let chosenDateRange = startDate..<endDate
        return unavailableDateRanges
            .filter { range in
                chosenDateRange.overlaps(range)
            }
            .isEmpty
    }
}
