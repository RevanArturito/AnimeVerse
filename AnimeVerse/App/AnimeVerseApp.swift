//
//  AnimeVerse.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI
import CoreData

@main
struct AnimeVerseApp: App {
    init() {
        _ = AppAssembly.shared 
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
