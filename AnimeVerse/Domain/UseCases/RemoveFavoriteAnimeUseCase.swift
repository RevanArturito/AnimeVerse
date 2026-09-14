//
//  RemoveFavoriteAnimeUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol RemoveFavoriteAnimeUseCase {
    func execute(id: Int) -> AnyPublisher<Void, Error>
}

final class RemoveFavoriteAnimeUseCaseImpl: RemoveFavoriteAnimeUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute(id: Int) -> AnyPublisher<Void, Error> {
        repository.removeFavorite(id: id)
    }
}
