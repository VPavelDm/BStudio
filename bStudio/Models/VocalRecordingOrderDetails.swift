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
    
    func createParamsForRequest() -> [String : Any] {
        ["client_name": clientName,
         "client_phone_number": clientPhoneNumber,
         "comments": comments,
         "start_time": startTime!,
         "end_time": endTime!,
         "selection_date": selectionDate.timeIntervalSince1970,
         "selection_index": selectionIndex]
    }
}
