//
//  ItemViewModel.swift
//  Flick Project
//
//  Created by Soumya Ranjan Mishra on 08/04/25.
//

import Foundation
import Combine

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private var cancellables = Set<AnyCancellable>()
    
    /// API Integration
    /*func loadPhotos() {
        NetworkManager.shared.fetchCuratedPhotos()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching photos: \(error)")
                }
            }, receiveValue: { [weak self] photos in
                self?.photos = photos
            })
            .store(in: &cancellables)
    }*/
    
    
    /// Local JSON
    func loadPhotos() {
        NetworkManager.shared.fetchLocalPhotos()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading local photos: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] photos in
                self?.photos = photos
            })
            .store(in: &cancellables)
    }
}
