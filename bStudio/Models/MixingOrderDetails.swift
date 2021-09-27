//
//  MixingOrderDetails.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 27.09.21.
//

import SwiftUI

class MixingOrderDetails: ObservableObject, DateDetails, MixingDetails, AuthenticationDetails {
    @Published var songs: [String] = [""]
    @Published var suggestionsForWork: String = ""
    @Published var selectedWorkTypeIndex = 0
    @Published var selectionDate: Date = Date()
    @Published var startTime: String?
    @Published var endTime: String?
    @Published var clientName: String = ""
    @Published var clientPhoneNumber: String = ""
    @Published var comments: String = ""
    let workTypes = ["На студии", "Удаленный"]
    
    // MARK: - Intents
    func addNewSong() {
        songs.append("")
    }
    func updateSong(at index: Int, with text: String) {
        songs[index] = text
    }
    func createParamsForRequest() -> [String : Any] {
        ["client_name": clientName,
         "client_phone_number": clientPhoneNumber,
         "comments": comments,
         "start_time": startTime!,
         "end_time": endTime!,
         "selection_date": selectionDate.timeIntervalSince1970,
         "suggestions_for_work": suggestionsForWork,
         "songs": songs,
         "selected_work_type_index": selectedWorkTypeIndex]
    }
}
