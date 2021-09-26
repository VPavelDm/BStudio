//
//  VocalRecordingType.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

enum VocalRecordingType: CaseIterable {
    case authorsTrack
    case cover
    case other
    
    var title: String {
        switch self {
        case .authorsTrack:
            return "Авторский трек"
        case .cover:
            return "Кавер"
        case .other:
            return "Другое"
        }
    }
}
