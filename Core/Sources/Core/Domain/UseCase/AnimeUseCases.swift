//
//  AnimeUseCases.swift
//  AnimeVerse
//
//  Tiap use case sekarang cukup type alias + factory, bukan protocol+class terpisah.
//

import Combine

public typealias GetTopAnimeUseCase = Interactor<Int, [Anime]>
public typealias GetAnimeDetailUseCase = Interactor<Int, AnimeDetail>
public typealias GetFavoriteAnimeUseCase = Interactor<Void, [Anime]>
public typealias AddFavoriteAnimeUseCase = Interactor<AnimeDetail, Void>
public typealias RemoveFavoriteAnimeUseCase = Interactor<Int, Void>
public typealias IsFavoriteAnimeUseCase = Interactor<Int, Bool>

public enum AnimeUseCaseFactory {
    public static func getTopAnime(repository: AnimeRepository) -> GetTopAnimeUseCase {
        Interactor { page in repository.getTopAnime(page: page) }
    }

    public static func getAnimeDetail(repository: AnimeRepository) -> GetAnimeDetailUseCase {
        Interactor { id in repository.getAnimeDetail(id: id) }
    }

    public static func getFavoriteAnime(repository: AnimeRepository) -> GetFavoriteAnimeUseCase {
        Interactor { _ in repository.getFavoriteAnime() }
    }

    public static func addFavoriteAnime(repository: AnimeRepository) -> AddFavoriteAnimeUseCase {
        Interactor { detail in repository.addFavorite(detail) }
    }

    public static func removeFavoriteAnime(repository: AnimeRepository) -> RemoveFavoriteAnimeUseCase {
        Interactor { id in repository.removeFavorite(id: id) }
    }

    public static func isFavoriteAnime(repository: AnimeRepository) -> IsFavoriteAnimeUseCase {
        Interactor { id in repository.isFavorite(id: id) }
    }
}
