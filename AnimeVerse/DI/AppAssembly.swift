//
//  AppAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Swinject
import Core
import Common
import HomeFeature
import DetailFeature
import FavoriteFeature
import AboutFeature

final class AppAssembly {

    static let shared = AppAssembly()

    let assembler: Assembler

    private init() {
        assembler = Assembler([
            CoreAssembly(),
            HomeAssembly(),
            DetailAssembly(),
            FavoriteAssembly()
        ])
    }

    var resolver: Resolver {
        assembler.resolver
    }
}
