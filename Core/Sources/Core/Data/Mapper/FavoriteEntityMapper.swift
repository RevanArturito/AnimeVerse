//
//  FavoriteEntityMapper.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

enum FavoriteEntityMapper {

    static func toEntity(_ managed: FavoriteAnimeEntity) -> Anime {
        Anime(
            id: Int(managed.malId),
            title: managed.title ?? "",
            imageUrl: managed.imageUrl ?? "",
            score: managed.score,
            episodes: Int(managed.episodes),
            status: managed.status ?? "-",
            isFavorite: true
        )
    }

    static func toEntity(_ managed: FavoriteAnimeEntity) -> AnimeDetail {
        AnimeDetail(
            id: Int(managed.malId),
            title: managed.title ?? "",
            imageUrl: managed.imageUrl ?? "",
            synopsis: managed.synopsis ?? "",
            score: managed.score,
            episodes: Int(managed.episodes),
            status: managed.status ?? "-",
            genres: (managed.genres ?? "").split(separator: ",").map(String.init),
            studios: [],
            duration: "-",
            rating: "-",
            isFavorite: true
        )
    }

    static func fill(_ managed: FavoriteAnimeEntity, from detail: AnimeDetail) {
        managed.malId = Int64(detail.id)
        managed.title = detail.title
        managed.imageUrl = detail.imageUrl
        managed.synopsis = detail.synopsis
        managed.score = detail.score ?? 0
        managed.episodes = Int32(detail.episodes ?? 0)
        managed.status = detail.status
        managed.genres = detail.genres.joined(separator: ",")
    }
}
