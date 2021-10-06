//
//  readJSON.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 6.10.21.
//

import Foundation

enum ReadJSONFileError: Error, LocalizedError {
    case fileIsNotExist(fileName: String)
    case dataHasBadFormat
    case parseJSONError
    case convertJSONError

    var errorDescription: String? {
        switch self {
        case .fileIsNotExist(let fileName):
            return "File \(fileName) is not exist"
        case .dataHasBadFormat:
            return "Data has bad format"
        case .parseJSONError:
            return "JSON parse error"
        case .convertJSONError:
            return "JSON convert error"
        }
    }
}

func readJSON<T>(jsonFileName: String) throws -> T {
    guard let jsonURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
        throw ReadJSONFileError.fileIsNotExist(fileName: jsonFileName)
    }
    guard let jsonData = try? Data(contentsOf: jsonURL) else {
        throw ReadJSONFileError.dataHasBadFormat
    }
    guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
        throw ReadJSONFileError.parseJSONError
    }
    guard let json = jsonObject as? T else {
        throw ReadJSONFileError.convertJSONError
    }
    return json
}

func readJSONData(jsonFileName: String) throws -> Data {
    guard let jsonURL = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else {
        throw ReadJSONFileError.fileIsNotExist(fileName: jsonFileName)
    }
    return try Data(contentsOf: jsonURL)
}
