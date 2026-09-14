//
//  GetAnimeDetailUseCase.swift.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol GetAnimeDetailUseCase {
    func execute(id: Int) -> AnyPublisher<AnimeDetail, Error>
}

final class GetAnimeDetailUseCaseImpl: GetAnimeDetailUseCase {
    private let repository: AnimeRepository
    init(repository: AnimeRepository) { self.repository = repository }

    func execute(id: Int) -> AnyPublisher<AnimeDetail, Error> {
        repository.getAnimeDetail(id: id)
    }
}
