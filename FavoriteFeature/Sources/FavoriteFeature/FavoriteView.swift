//
//  FavoriteView.swift
//  AnimeVerse
//

import SwiftUI
import Core
import Common

public struct FavoriteView<DetailContent: View>: View {
    @StateObject var viewModel: FavoriteViewModel
    let detailViewBuilder: (Int) -> DetailContent

    public init(
        viewModel: FavoriteViewModel,
        @ViewBuilder detailViewBuilder: @escaping (Int) -> DetailContent
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.detailViewBuilder = detailViewBuilder
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                Color.bgPrimary.ignoresSafeArea()

                if viewModel.isLoading && viewModel.favorites.isEmpty {
                    ProgressView().tint(.accentPink)
                } else if viewModel.favorites.isEmpty {
                    Text("favorite.empty".localized)
                        .font(.body())
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                } else {
                    List(viewModel.favorites) { anime in
                        AnimeRowView(anime: anime)
                            .background(
                                NavigationLink(value: anime.id) { EmptyView() }
                                    .opacity(0)
                            )
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("favorite.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Int.self) { animeId in
                // Panggil builder di sini tanpa kenal AppAssembly / DetailView
                detailViewBuilder(animeId)
            }
            .onAppear { viewModel.reload() }
        }
        .tint(.accentPink)
    }
}
