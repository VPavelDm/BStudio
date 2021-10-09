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
    @Published var chosenAuthorID: Int?
    @Published var demoURL: URL?
    var service: Service?
    let workTypes = ["На студии", "Удаленный"]
    
    // MARK: - Intents
    func addNewSong() {
        songs.append("")
    }
    func updateSong(at index: Int, with text: String) {
        songs[index] = text
    }
    func createParamsForRequest() -> [String: Any] {
        [
            "client_name": clientName,
            "phone_number": clientPhoneNumber,
            "comments": comments,
            "author_id": chosenAuthorID!,
            "service": StudioMapper().map(from: service!),
            "work_type": workTypes[selectedWorkTypeIndex],
            "suggestions_for_work": suggestionsForWork,
            "songs": songs,
            "studio_id": 1,
            "start_time": DateMapper(time: startTime!, date: selectionDate).serverTime,
            "end_time": DateMapper(time: endTime!, date: selectionDate).serverTime,
            "demo_url": ""
        ]
    }
    func clearOrderDetails() {
        songs = [""]
        suggestionsForWork = ""
        selectedWorkTypeIndex = 0
        selectionDate = Date()
        startTime = nil
        endTime = nil
        clientName = ""
        clientPhoneNumber = ""
        comments = ""
        chosenAuthorID = nil
        service = nil
        demoURL = nil
    }
}
