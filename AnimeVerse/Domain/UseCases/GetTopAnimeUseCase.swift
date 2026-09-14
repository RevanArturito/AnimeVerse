//
//  GetTopAnimeUseCase.swift.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol GetTopAnimeUseCase {
    func execute(page: Int) -> AnyPublisher<[Anime], Error>
}

final class GetTopAnimeUseCaseImpl: GetTopAnimeUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute(page: Int) -> AnyPublisher<[Anime], Error> {
        repository.getTopAnime(page: page)
    }
}
