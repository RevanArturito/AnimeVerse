//
//  MainTabView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI
import Swinject

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: AppAssembly.shared.resolver.resolve(HomeViewModel.self)!)
                .tabItem { Label("Home", systemImage: "house") }

            FavoriteView(viewModel: AppAssembly.shared.resolver.resolve(FavoriteViewModel.self)!)
                .tabItem { Label("Favorit", systemImage: "heart") }

            AboutView()
                .tabItem { Label("About", systemImage: "person.crop.circle") }
        }
        .tint(.accentPink)
        .preferredColorScheme(.dark)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color.bgCard)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
#Preview {
    MainTabView()
}
