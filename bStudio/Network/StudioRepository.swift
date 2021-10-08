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
    func makeReservation(params: [String: Any], completion: @escaping (Result<([Author], [String], [Reservation]), Error>) -> Void) {
        guard let request = makeRequest(params: params) else { return }
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
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
        guard let url = URL(string: "https://fx6h6bgyvj.execute-api.eu-central-1.amazonaws.com/loadStudios") else { return nil }
        return URLRequest(url: url)
    }
    private func makeRequest(params: [String: Any]) -> URLRequest? {
        let body = createBody(params: params)
        guard let url = URL(string: "https://z7qul7zy1m.execute-api.eu-central-1.amazonaws.com/makeReservation") else { return nil }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body
        request.httpMethod = "POST"
        return request
    }
    private func createBody(params: [String: Any]) -> Data {
        try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
    }
}
