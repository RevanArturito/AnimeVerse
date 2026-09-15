//
//  AnimeMapper.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

enum AnimeMapper {

    static func toEntity(_ dto: AnimeDataDTO, isFavorite: Bool = false) -> Anime {
        Anime(
            id: dto.malId,
            title: dto.title,
            imageUrl: dto.images.jpg.imageUrl,
            score: dto.score,
            episodes: dto.episodes,
            status: dto.status ?? "-",
            isFavorite: isFavorite
        )
    }

    static func toEntity(_ dto: AnimeDetailDataDTO, isFavorite: Bool = false) -> AnimeDetail {
        AnimeDetail(
            id: dto.malId,
            title: dto.title,
            imageUrl: dto.images.jpg.largeImageUrl ?? dto.images.jpg.imageUrl,
            synopsis: dto.synopsis ?? "Sinopsis tidak tersedia.",
            score: dto.score,
            episodes: dto.episodes,
            status: dto.status ?? "-",
            genres: dto.genres.map { $0.name },
            studios: dto.studios.map { $0.name },
            duration: dto.duration ?? "-",
            rating: dto.rating ?? "-",
            isFavorite: isFavorite
        )
    }
}
