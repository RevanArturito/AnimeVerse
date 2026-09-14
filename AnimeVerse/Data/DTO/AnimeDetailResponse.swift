//
//  AnimeDetailResponse.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

struct AnimeDetailResponse: Decodable {
    let data: AnimeDetailDataDTO
}

struct AnimeDetailDataDTO: Decodable {
    let malId: Int
    let title: String
    let images: ImagesDTO
    let synopsis: String?
    let score: Double?
    let episodes: Int?
    let status: String?
    let duration: String?
    let rating: String?
    let genres: [GenreDTO]
    let studios: [GenreDTO]

    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case title, images, synopsis, score, episodes, status, duration, rating, genres, studios
    }
}

struct GenreDTO: Decodable {
    let name: String
}
