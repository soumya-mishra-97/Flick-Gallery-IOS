//
//  Flick_ProjectTests.swift
//  Flick ProjectTests
//
//  Created by Ashis Kumar Mishra on 09/04/25.
//

import XCTest
import Combine
@testable import Flick_Project

final class Flick_ProjectTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    // MARK: - 1. Test Photo Decoding
    
    func testPhotoDecoding() throws {
        let json = """
        {
            "photos": [
                {
                    "id": 123,
                    "photographer": "John Doe",
                    "src": {
                        "medium": "https://example.com/photo.jpg"
                    }
                }
            ]
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PhotoResponse.self, from: json)
        XCTAssertEqual(decoded.photos.count, 1)
        XCTAssertEqual(decoded.photos.first?.id, 123)
        XCTAssertEqual(decoded.photos.first?.photographer, "John Doe")
        XCTAssertEqual(decoded.photos.first?.src.medium, "https://example.com/photo.jpg")
    }

    // MARK: - 2. Test ViewModel Loads Photos from API (Mocked)

    func testViewModelLoadsPhotos() {
        let viewModel = PhotoViewModel()
        let expectation = XCTestExpectation(description: "Photos fetched")

        // Observe changes
        viewModel.$photos
            .dropFirst()
            .sink { photos in
                XCTAssertGreaterThan(photos.count, 0, "Photos should be fetched from API")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadPhotos()

        wait(for: [expectation], timeout: 5.0)
    }

    // MARK: - 3. Test API Failure

    func testAPIFailureHandling() {
        // Invalid URL on purpose
        let badManager = NetworkManagerFake()
        let expectation = XCTestExpectation(description: "API fails")

        badManager.fetchCuratedPhotos()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected API failure")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3.0)
    }
}

class NetworkManagerFake {
    func fetchCuratedPhotos(page: Int = 1, perPage: Int = 20) -> AnyPublisher<[Photo], Error> {
        return Fail(error: URLError(.notConnectedToInternet))
            .eraseToAnyPublisher()
    }
}
