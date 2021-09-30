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
    func makeReservation(params: MakeReservationParams) {
        let body =
        """
        {
            "phone_number": "\(params.phoneNumber)",
            "client_name": "\(params.clientName)",
            "start_time": \(params.startTime),
            "end_time": \(params.endTime),
            "author_id": \(params.authorID),
            "studio_id": 1
        }
        """
        guard let request = makeRequest(body: Data(body.utf8)) else { return }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(String(data: data, encoding: .utf8) ?? "parse error")
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
    private func makeRequest(body: Data) -> URLRequest? {
        guard let url = URL(string: "https://x958s2uw0m.execute-api.eu-central-1.amazonaws.com/prod/") else { return nil }
        var request = URLRequest(url: url)
        request.addValue("TbTbOv0BkZ1Hf5M8M8Y7z8Tpc6qoa8HZ7NrPGIF3", forHTTPHeaderField: "x-api-key")
        request.httpBody = body
        request.httpMethod = "POST"
        return request
    }
}
