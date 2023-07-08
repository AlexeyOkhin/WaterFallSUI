//
//  APIService.swift
//  WaterFallSUI
//
//  Created by Djinsolobzik on 05.07.2023.
//
import Foundation
import Combine

class APIService<T: Codable> {
    let request: URLRequest

    init(_ request :URLRequest) {
        self.request = request
    }

    func getData() -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
