//
//  StudioRepository.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

class StudioRepository {
    
    func loadStudio(completion: @escaping (Result<([Author], [String], [Reservation]), Error>) -> Void) {
        URLSession.shared.dataTask(with: loadRequest!) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                self?.handleStudioLoadResponse(data: data, completion: completion)
            }
        }
        .resume()
    }
    
    private func handleStudioLoadResponse(data: Data, completion: @escaping (Result<([Author], [String], [Reservation]), Error>) -> Void) {
        let mapper = StudioMapper()
        let jsonDecoder = JSONDecoder()
        if let studio = try? jsonDecoder.decode(StudioTO.self, from: data) {
            let authors = mapper.map(from: studio.authors)
            let reservations = mapper.map(from: studio.reservations)
            DispatchQueue.main.async {
                completion(.success((authors, studio.workTimes, reservations)))
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(ServerError.parseError))
            }
        }
    }
    
    private var loadRequest: URLRequest? {
        guard let url = URL(string: "https://jl9kbc3dfl.execute-api.eu-central-1.amazonaws.com/prod/") else { return nil }
        var request = URLRequest(url: url)
        request.addValue("TbTbOv0BkZ1Hf5M8M8Y7z8Tpc6qoa8HZ7NrPGIF3", forHTTPHeaderField: "x-api-key")
        return request
    }
}
