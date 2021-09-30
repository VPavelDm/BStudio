//
//  MixingOrderDetails.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 27.09.21.
//

import SwiftUI

class MixingOrderDetails: ObservableObject, DateDetails, MixingDetails, AuthenticationDetails, AuthorListDetails {
    @Published var songs: [String] = [""]
    @Published var suggestionsForWork: String = ""
    @Published var selectedWorkTypeIndex = 0
    @Published var selectionDate: Date = Date()
    @Published var startTime: String?
    @Published var endTime: String?
    @Published var clientName: String = ""
    @Published var clientPhoneNumber: String = ""
    @Published var comments: String = ""
    @Published var chosenAuthorID: String?
    let workTypes = ["На студии", "Удаленный"]
    
    // MARK: - Intents
    func addNewSong() {
        songs.append("")
    }
    func updateSong(at index: Int, with text: String) {
        songs[index] = text
    }
    #warning("Set correct authorID")
    func createParamsForRequest() -> MakeReservationParams {
        .init(phoneNumber: clientPhoneNumber,
              clientName: clientName,
              startTime: startTime!,
              endTime: endTime!,
              date: selectionDate,
              authorID: 1)

    }
}
