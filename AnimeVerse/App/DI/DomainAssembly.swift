//
//  DomainAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Swinject

final class DomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetTopAnimeUseCase.self) { r in
            GetTopAnimeUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(SearchAnimeUseCase.self) { r in
            SearchAnimeUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(GetAnimeDetailUseCase.self) { r in
            GetAnimeDetailUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(GetFavoriteAnimeUseCase.self) { r in
            GetFavoriteAnimeUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(AddFavoriteAnimeUseCase.self) { r in
            AddFavoriteAnimeUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(RemoveFavoriteAnimeUseCase.self) { r in
            RemoveFavoriteAnimeUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(IsFavoriteAnimeUseCase.self) { r in
            IsFavoriteAnimeUseCaseImpl(repository: r.resolve(AnimeRepository.self)!)
        }
    }
}
