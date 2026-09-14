//
//  PresentationAssembly.swift.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Swinject

final class PresentationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewModel.self) { r in
            HomeViewModel(
                getTopAnimeUseCase: r.resolve(GetTopAnimeUseCase.self)!
            )
        }

        container.register(FavoriteViewModel.self) { r in
            FavoriteViewModel(getFavoriteAnimeUseCase: r.resolve(GetFavoriteAnimeUseCase.self)!)
        }

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
