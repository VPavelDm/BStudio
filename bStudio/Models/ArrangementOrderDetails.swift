//
//  ArrangementOrderDetails.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

class ArrangementOrderDetails: ObservableObject, DateDetails, ArrangementDetails, AuthenticationDetails, AuthorListDetails {
    @Published var songs: [String] = [""]
    @Published var suggestionsForWork: String = ""
    @Published var selectedWorkTypeIndex = 0
    @Published var selectionDate: Date = Date()
    @Published var startTime: String?
    @Published var endTime: String?
    @Published var clientName: String = ""
    @Published var clientPhoneNumber: String = ""
    @Published var comments: String = ""
    @Published var chosenAuthorID: Int?
    let workTypes = ["На студии", "Удаленный"]
    
    // MARK: - Intents
    func addNewSong() {
        songs.append("")
    }
    func updateSong(at index: Int, with text: String) {
        songs[index] = text
    }
    func createParamsForRequest() -> MakeReservationParams {
        .init(phoneNumber: clientPhoneNumber,
              clientName: clientName,
              startTime: startTime!,
              endTime: endTime!,
              date: selectionDate,
              authorID: chosenAuthorID!)
    }
}
