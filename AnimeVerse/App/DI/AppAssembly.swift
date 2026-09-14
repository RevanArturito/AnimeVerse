//
//  AppAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Swinject

final class AppAssembly {
    static let shared = AppAssembly()
    let assembler: Assembler

    private init() {
        assembler = Assembler([
            DataAssembly(),
            DomainAssembly(),
            PresentationAssembly()
        ])
    }

    var resolver: Resolver {
        assembler.resolver
    }
}
