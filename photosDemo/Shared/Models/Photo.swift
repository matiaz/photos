//
//  Photo.swift
//  photosDemo
//
//  Created by matiaz on 14/3/22.
//

import Foundation

struct Photo: Codable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
