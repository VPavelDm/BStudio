//
//  OrderDetails.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

class OrderDetails: ObservableObject {
    
    @Published var songs: [String] = [""]
    @Published var comments: String = ""
    @Published var selectedWorkTypeIndex = 0
    let workTypes = ["На студии", "Удаленный"]
    
    // MARK: - Intents
    func addNewSong() {
        songs.append("")
    }
    func updateSong(at index: Int, with text: String) {
        songs[index] = text
    }
}
