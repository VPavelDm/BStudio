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
    func createParamsForRequest() -> [String: Any] {
        ["client_name": clientName,
         "phone_number": clientPhoneNumber,
         "start_time": DateMapper(time: startTime!, date: selectionDate).serverTime,
         "end_time": DateMapper(time: endTime!, date: selectionDate).serverTime,
         "work_type": workTypes[selectedWorkTypeIndex],
         "suggestions_for_work": suggestionsForWork,
         "comments": comments,
         "author_id": chosenAuthorID!]
    }
}
