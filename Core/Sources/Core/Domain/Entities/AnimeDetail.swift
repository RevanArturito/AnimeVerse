//
//  AnimeDetail.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

public struct AnimeDetail: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let imageUrl: String
    public let synopsis: String
    public let score: Double?
    public let episodes: Int?
    public let status: String
    public let genres: [String]
    public let studios: [String]
    public let duration: String
    public let rating: String
    public var isFavorite: Bool = false

    public init(
        id: Int,
        title: String,
        imageUrl: String,
        synopsis: String,
        score: Double?,
        episodes: Int?,
        status: String,
        genres: [String],
        studios: [String],
        duration: String,
        rating: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.synopsis = synopsis
        self.score = score
        self.episodes = episodes
        self.status = status
        self.genres = genres
        self.studios = studios
        self.duration = duration
        self.rating = rating
        self.isFavorite = isFavorite
    }
}
