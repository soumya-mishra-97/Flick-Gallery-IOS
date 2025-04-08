//
//  Photo.swift
//  Flick Project
//
//  Created by Soumya Ranjan Mishra on 08/04/25.
//

import Foundation

/// API Integration
/*struct Photo: Codable, Identifiable {
    let id: Int
    let photographer: String
    let src: PhotoSource

    struct PhotoSource: Codable {
        let medium: String
    }
}

struct PhotoResponse: Codable {
    let photos: [Photo]
}*/

/// Local JSON
struct Photo: Codable, Identifiable {
    let id: Int
    let title: String
    let imageUrl: String    
}
