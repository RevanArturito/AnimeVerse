//
//  Anime.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

public struct Anime: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let imageUrl: String
    public let score: Double?
    public let episodes: Int?
    public let status: String
    public var isFavorite: Bool

    public init(id: Int, title: String, imageUrl: String, score: Double?, episodes: Int?, status: String, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.score = score
        self.episodes = episodes
        self.status = status
        self.isFavorite = isFavorite
    }
}
