//
//  NetworkManager.swift
//  Flick Project
//
//  Created by Soumya Ranjan Mishra on 08/04/25.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    
    private init() {}
    
    /// API Integration
    /*func fetchCuratedPhotos(page: Int = 1, perPage: Int = 20) -> AnyPublisher<[Photo], Error> {
        guard let url = URL(string: "\(BASE_URL)curated?page=\(page)&per_page=\(perPage)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue(API_KEY, forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PhotoResponse.self, decoder: JSONDecoder())
            .map { $0.photos }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }*/
    
    /// Local JSON
    func fetchLocalPhotos() -> AnyPublisher<[Photo], Error> {
        guard let url = Bundle.main.url(forResource: "Photos", withExtension: "json") else {
            return Fail(error: URLError(.fileDoesNotExist)).eraseToAnyPublisher()
        }
        
        do {
            let data = try Data(contentsOf: url)
            let photos = try JSONDecoder().decode([Photo].self, from: data)
            return Just(photos)
                .setFailureType(to: Error.self)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

