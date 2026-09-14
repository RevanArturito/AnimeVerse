//
//  HomeAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

public final class HomeAssembly: Assembly {
    
    public init() {}
    
    public func assemble(
        container: Container
    ) {
        container.register(
            HomeViewModel.self
        ) { resolver in
            
            HomeViewModel(
                getTopAnimeUseCase: resolver.resolve(
                    GetTopAnimeUseCase.self
                )!
            )
        }
    }
}
