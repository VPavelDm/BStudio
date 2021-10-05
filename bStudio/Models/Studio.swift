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
    var isStudioLoaded: Bool { !authors.isEmpty }
    var unavailableDateRanges: [Range<Date>] {
        reservations.map { $0.timeInterval }
    }
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
        repository.makeReservation(params: params, completion: completion)
    }
    func workTimes(for date: Date) -> [String] {
        _workTimes
            .map { time in
                DateMapper(time: time, date: date).serverTime
            }
            .map { time in
                Date(timeIntervalSince1970: time)
            }
            .filter { time in
                !unavailableDateRanges.contains(where: { $0.contains(time) })
            }
            .map { time in
                dateFormatter.string(from: time)
            }
    }
}
