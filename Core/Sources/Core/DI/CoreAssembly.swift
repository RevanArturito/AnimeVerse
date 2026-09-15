//
//  CoreAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Swinject

public final class CoreAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AnimeRemoteDataSource.self) { _ in
            AnimeRemoteDataSourceImpl()
        }.inObjectScope(.container)
        
        container.register(AnimeLocalDataSource.self) { _ in
            AnimeLocalDataSourceImpl()
        }.inObjectScope(.container)
        
        container.register(AnimeRepository.self) { r in
            AnimeRepositoryImpl(
                remote: r.resolve(AnimeRemoteDataSource.self)!,
                local: r.resolve(AnimeLocalDataSource.self)!
            )
        }.inObjectScope(.container)
        
        container.register(GetTopAnimeUseCase.self) { r in
            AnimeUseCaseFactory.getTopAnime(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(GetAnimeDetailUseCase.self) { r in
            AnimeUseCaseFactory.getAnimeDetail(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(GetFavoriteAnimeUseCase.self) { r in
            AnimeUseCaseFactory.getFavoriteAnime(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(AddFavoriteAnimeUseCase.self) { r in
            AnimeUseCaseFactory.addFavoriteAnime(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(RemoveFavoriteAnimeUseCase.self) { r in
            AnimeUseCaseFactory.removeFavoriteAnime(repository: r.resolve(AnimeRepository.self)!)
        }
        container.register(IsFavoriteAnimeUseCase.self) { r in
            AnimeUseCaseFactory.isFavoriteAnime(repository: r.resolve(AnimeRepository.self)!)
        }
    }
}
