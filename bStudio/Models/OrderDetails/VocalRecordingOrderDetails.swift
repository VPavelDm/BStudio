//
//  VocalRecordingOrderDetails.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 27.09.21.
//

import SwiftUI

class VocalRecordingOrderDetails: ObservableObject, VocalRecordingTypeDetails, DateDetails, AuthenticationDetails {
    @Published var clientName: String = ""
    @Published var clientPhoneNumber: String = ""
    @Published var comments: String = ""
    @Published var selectionDate: Date = Date()
    @Published var startTime: String?
    @Published var endTime: String?
    @Published var selectionIndex: Int = 0
    @Published var otherText: String = ""
    func createParamsForRequest() -> [String: Any] {
        ["service": StudioMapper().map(from: .vocalRecording),
         "studio_id": 1,
         "start_time": DateMapper(time: startTime!, date: selectionDate).serverTime,
         "end_time": DateMapper(time: endTime!, date: selectionDate).serverTime]
    }
}