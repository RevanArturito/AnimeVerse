//
//  HomeView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI
import Swinject

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgPrimary.ignoresSafeArea()

                if viewModel.isLoading && viewModel.animeList.isEmpty {
                    ProgressView()
                        .tint(.accentPink)
                } else if viewModel.animeList.isEmpty {
                    Text("Tidak ada hasil")
                        .font(.body())
                        .foregroundColor(.textSecondary)
                } else {
                    List(viewModel.animeList) { anime in
                        NavigationLink(value: anime.id) {
                            AnimeRowView(anime: anime)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .refreshable { viewModel.refresh() }
                }
            }
            .navigationTitle("Top Anime")
            .searchable(text: $viewModel.searchQuery, prompt: "Cari anime...")
            .navigationDestination(for: Int.self) { animeId in
                DetailView(viewModel: AppAssembly.shared.resolver.resolve(DetailViewModel.self, argument: animeId)!)
            }
            .onAppear { viewModel.onAppear() }
            .alert(
                "Gagal memuat data",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
        .tint(.accentPink)
    }
}
