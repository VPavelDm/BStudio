//
//  Service.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

enum Service: CaseIterable {
    case arrangement
    case vocalRecording
    case mixing
    case mastering
    
    var title: String {
        switch self {
        case .arrangement:
            return "Написание аранжировки"
        case .vocalRecording:
            return "Запись вокала"
        case .mixing:
            return "Сведение"
        case .mastering:
            return "Мастеринг"
        }
    }
}
