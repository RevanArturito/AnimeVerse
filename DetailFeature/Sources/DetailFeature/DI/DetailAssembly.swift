//
//  DetailAssembly.swift
//  AnimeVerse
//

import Swinject
import Core

public final class DetailAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(DetailViewModel.self) { (r, animeId: Int) in
            DetailViewModel(
                animeId: animeId,
                getAnimeDetailUseCase: r.resolve(GetAnimeDetailUseCase.self)!,
                addFavoriteUseCase: r.resolve(AddFavoriteAnimeUseCase.self)!,
                removeFavoriteUseCase: r.resolve(RemoveFavoriteAnimeUseCase.self)!
            )
        }
    }
}
