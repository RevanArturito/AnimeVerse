//
//  GetFavoriteAnimeUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol GetFavoriteAnimeUseCase {
    func execute() -> AnyPublisher<[Anime], Error>
}

final class GetFavoriteAnimeUseCaseImpl: GetFavoriteAnimeUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute() -> AnyPublisher<[Anime], Error> {
        repository.getFavoriteAnime()
    }
}
