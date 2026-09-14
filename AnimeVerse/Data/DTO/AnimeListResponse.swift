//
//  AnimeListRespone.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

struct AnimeListResponse: Decodable {
    let data: [AnimeDataDTO]
}

struct AnimeSearchResponse: Decodable {
    let data: [AnimeDataDTO]
}

struct AnimeDataDTO: Decodable {
    let malId: Int
    let title: String
    let images: ImagesDTO
    let score: Double?
    let episodes: Int?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case title, images, score, episodes, status
    }
}

struct ImagesDTO: Decodable {
    let jpg: JpgImageDTO
}

struct JpgImageDTO: Decodable {
    let imageUrl: String
    let largeImageUrl: String?

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case largeImageUrl = "large_image_url"
    }
}
