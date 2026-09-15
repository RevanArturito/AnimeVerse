//
//  AnimeRepositoryImpl.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

final class AnimeRepositoryImpl: AnimeRepository {
    private let remote: AnimeRemoteDataSource
    private let local: AnimeLocalDataSource

    init(remote: AnimeRemoteDataSource, local: AnimeLocalDataSource) {
        self.remote = remote
        self.local = local
    }

    func getTopAnime(page: Int) -> AnyPublisher<[Anime], Error> {
        remote.getTopAnime(page: page)
            .flatMap { [weak self] dtos -> AnyPublisher<[Anime], Error> in
                self?.attachFavoriteStatus(dtos: dtos) ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetail, Error> {
        Publishers.Zip(remote.getAnimeDetail(id: id), local.isFavorite(id: id))
            .map { dto, favorite in AnimeMapper.toEntity(dto, isFavorite: favorite) }
            .eraseToAnyPublisher()
    }

    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        local.getFavorites()
            .map { $0.map(FavoriteEntityMapper.toEntity) }
            .eraseToAnyPublisher()
    }

    func addFavorite(_ anime: AnimeDetail) -> AnyPublisher<Void, Error> {
        local.addFavorite(anime)
    }

    func removeFavorite(id: Int) -> AnyPublisher<Void, Error> {
        local.removeFavorite(id: id)
    }

    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        local.isFavorite(id: id)
    }

    private func attachFavoriteStatus(dtos: [AnimeDataDTO]) -> AnyPublisher<[Anime], Error> {
        local.getFavorites()
            .map { favorites in
                let favoriteIds = Set(favorites.map { Int($0.malId) })
                return dtos.map { AnimeMapper.toEntity($0, isFavorite: favoriteIds.contains($0.malId)) }
            }
            .eraseToAnyPublisher()
    }
}
