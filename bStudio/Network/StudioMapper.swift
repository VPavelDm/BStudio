//
//  StudioMapper.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

class StudioMapper {
    func map(from author: AuthorTO) -> Author {
        .init(name: author.name,
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
        .init(timeInterval: map(startTime: reservation.startTime, endTime: reservation.endTime),
              phoneNumber: reservation.phoneNumber,
              clientName: reservation.clientName)
    }
    func map(from reservations: [ReservationTO]) -> [Reservation] {
        reservations.map(map(from:))
    }
    
    
    private func map(startTime: Double, endTime: Double) -> ClosedRange<Date> {
        map(time: startTime)...map(time: endTime)
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
    
    
    func map(from service: String) -> Service? {
        switch service {
        case "arrangement":
            return .arrangement
        case "vocal_recording":
            return .vocalRecording
        case "mixing":
            return .mixing
        case "mastering":
            return .mastering
        default:
            return nil
        }
    }
    func map(from services: [String]) -> [Service] {
        services.compactMap(map(from:))
    }
    
}
