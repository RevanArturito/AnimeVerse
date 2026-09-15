//
//  HomeView.swift
//  AnimeVerse
//

import SwiftUI
import Core
import Common
import DetailFeature

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
                    Text("home.empty_result".localized)
                        .font(.body())
                        .foregroundColor(.textSecondary)
                } else {
                    List(viewModel.animeList) { anime in
                        AnimeRowView(anime: anime)
                            .background(
                                NavigationLink(value: anime.id) { EmptyView() }
                                    .opacity(0)
                            )
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .refreshable { viewModel.refresh() }
                }
            }
            .navigationTitle("home.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchQuery, prompt: "home.search_placeholder".localized)
            .navigationDestination(for: Int.self) { animeId in
                DetailView(viewModel: AppContainer.shared.container.resolve(DetailViewModel.self, argument: animeId)!)
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
