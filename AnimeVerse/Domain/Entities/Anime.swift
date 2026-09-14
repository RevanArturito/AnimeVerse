//
//  Anime.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

struct Anime: Equatable, Identifiable {
    let id: Int
    let title: String
    let imageUrl: String
    let score: Double?
    let episodes: Int?
    let status: String
    var isFavorite: Bool = false
}
