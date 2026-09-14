//
//  DataAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Swinject

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AnimeRemoteDataSource.self) { _ in
            AnimeRemoteDataSourceImpl()
        }.inObjectScope(.container)

        container.register(AnimeLocalDataSource.self) { _ in
            AnimeLocalDataSourceImpl()
        }.inObjectScope(.container)

        container.register(AnimeRepository.self) { resolver in
            AnimeRepositoryImpl(
                remote: resolver.resolve(AnimeRemoteDataSource.self)!,
                local: resolver.resolve(AnimeLocalDataSource.self)!
            )
        }.inObjectScope(.container)
    }
}
