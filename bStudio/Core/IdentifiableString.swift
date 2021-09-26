//
//  IdentifiableString.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

struct IdentifiableString: Identifiable {
    var id: String { text }
    var text: String
}
