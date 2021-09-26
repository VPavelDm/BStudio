//
//  Service.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

struct Service: Identifiable {
    var id: Int
    var name: String
    var steps: [Step]
}
