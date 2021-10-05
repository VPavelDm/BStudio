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
    @Published var workTimes: [String] = []
    var isStudioLoaded: Bool { !authors.isEmpty }
    var unavailableDateRanges: [ClosedRange<Date>] {
        reservations.map { $0.timeInterval }
    }
    
    // MARK: - Intents
    func getAuthors(for service: Service) -> [Author] {
        authors.filter { $0.services.contains(service) }
    }
    func loadStudio() {
        repository.loadStudio { [weak self] response in
            switch response {
            case let .success((authors, workTimes, reservations)):
                self?.authors = authors
                self?.workTimes = workTimes
                self?.reservations = reservations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeReservation(params: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        repository.makeReservation(params: params, completion: completion)
    }
}
