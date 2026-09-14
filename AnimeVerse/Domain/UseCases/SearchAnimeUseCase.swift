//
//  SearchAnimeUseCase.swift.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine
import Foundation

protocol SearchAnimeUseCase {
    func execute(query: String) -> AnyPublisher<[Anime], Error>
}

final class SearchAnimeUseCaseImpl: SearchAnimeUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute(query: String) -> AnyPublisher<[Anime], Error> {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return repository.searchAnime(query: query)
    }
}
