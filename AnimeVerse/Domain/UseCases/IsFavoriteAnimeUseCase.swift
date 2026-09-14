//
//  IsFavoriteAnimeUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol IsFavoriteAnimeUseCase {
    func execute(id: Int) -> AnyPublisher<Bool, Error>
}

final class IsFavoriteAnimeUseCaseImpl: IsFavoriteAnimeUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute(id: Int) -> AnyPublisher<Bool, Error> {
        repository.isFavorite(id: id)
    }
}
