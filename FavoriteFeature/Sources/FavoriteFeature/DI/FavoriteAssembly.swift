//
//  FavoriteAssembly.swift
//  AnimeVerse
//

import Swinject
import Core

public final class FavoriteAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(FavoriteViewModel.self) { r in
            FavoriteViewModel(getFavoriteAnimeUseCase: r.resolve(GetFavoriteAnimeUseCase.self)!)
        }
    }
}
