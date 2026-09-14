//
//  AnimeDetail.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

struct AnimeDetail: Equatable, Identifiable {
    let id: Int
    let title: String
    let imageUrl: String
    let synopsis: String
    let score: Double?
    let episodes: Int?
    let status: String
    let genres: [String]
    let studios: [String]
    let duration: String
    let rating: String
    var isFavorite: Bool = false
}
