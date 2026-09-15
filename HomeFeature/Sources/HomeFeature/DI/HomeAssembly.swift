//
//  HomeAssembly.swift
//  AnimeVerse
//

import Swinject
import Core

public final class HomeAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(HomeViewModel.self) { r in
            HomeViewModel(getTopAnimeUseCase: r.resolve(GetTopAnimeUseCase.self)!)
        }
    }
}
