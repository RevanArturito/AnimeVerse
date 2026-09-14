//
//  AddFavoriteAnimeUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol AddFavoriteAnimeUseCase {
    func execute(anime: AnimeDetail) -> AnyPublisher<Void, Error>
}

final class AddFavoriteAnimeUseCaseImpl: AddFavoriteAnimeUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute(anime: AnimeDetail) -> AnyPublisher<Void, Error> {
        repository.addFavorite(anime)
    }
}
