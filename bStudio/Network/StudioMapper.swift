//
//  StudioMapper.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

class StudioMapper {
    func map(from author: AuthorTO) -> Author {
        .init(id: author.id,
              name: author.name,
              imageURL: author.imageURL,
              arrangements: map(from: author.arrangements),
              masteringAndMixing: author.masteringAndMixing,
              songs: map(from: author.songs),
              services: map(from: author.services))
    }
    func map(from authors: [AuthorTO]) -> [Author] {
        authors.map(map(from:))
    }
    
    
    func map(from reservation: ReservationTO) -> Reservation {
        .init(timeInterval: map(startTime: reservation.startTime, endTime: reservation.endTime))
    }
    func map(from reservations: [ReservationTO]) -> [Reservation] {
        reservations.map(map(from:))
    }
    
    
    private func map(startTime: Double, endTime: Double) -> Range<Date> {
        map(time: startTime)..<map(time: endTime)
    }
    private func map(time: Double) -> Date {
        Date(timeIntervalSince1970: time)
    }
    
    
    func map(from arrangements: [ArrangementTO]) -> [Arrangement] {
        arrangements.map(map(from:))
    }
    func map(from arrangement: ArrangementTO) -> Arrangement {
        .init(name: arrangement.name,
              price: arrangement.price)
    }
    
    
    func map(from song: SongTO) -> Song {
        .init(imageURL: song.imageURL,
              userFriendlyName: song.userFriendlyName,
              songName: song.songName)
    }
    func map(from songs: [SongTO]) -> [Song] {
        songs.map(map(from:))
    }
    
    private let arrangementKey = "arrangement"
    private let vocalRecordingKey = "vocal_recording"
    private let mixingKey = "mixing"
    private let masteringKey = "mastering"
    func map(from service: String) -> Service? {
        switch service {
        case arrangementKey:
            return .arrangement
        case vocalRecordingKey:
            return .vocalRecording
        case mixingKey:
            return .mixing
        case masteringKey:
            return .mastering
        default:
            return nil
        }
    }
    func map(from services: [String]) -> [Service] {
        services.compactMap(map(from:))
    }
    func map(from service: Service) -> String {
        switch service {
        case .arrangement:
            return arrangementKey
        case .vocalRecording:
            return vocalRecordingKey
        case .mixing:
            return mixingKey
        case .mastering:
            return masteringKey
        }
    }
    
}
