//
//  FavoriteView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI
import Swinject

struct FavoriteView: View {
    @StateObject var viewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgPrimary.ignoresSafeArea()

                if viewModel.isLoading && viewModel.favorites.isEmpty {
                    ProgressView().tint(.accentPink)
                } else if viewModel.favorites.isEmpty {
                    Text("Belum ada anime favorit.\nTekan ikon hati di halaman detail.")
                        .font(.body())
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                } else {
                    List(viewModel.favorites) { anime in
                        NavigationLink(value: anime.id) {
                            AnimeRowView(anime: anime)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Favorit")
            .navigationDestination(for: Int.self) { animeId in
                DetailView(viewModel: AppAssembly.shared.resolver.resolve(DetailViewModel.self, argument: animeId)!)
            }
            .onAppear { viewModel.reload() }
        }
        .tint(.accentPink)
    }
}

