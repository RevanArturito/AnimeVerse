//
//  FavoriteViewModel.swift
//  AnimeVerse
//

import Combine
import Foundation
import Core

final class FavoriteViewModel: ObservableObject {
    @Published private(set) var favorites: [Anime] = []
    @Published private(set) var isLoading: Bool = false

    private let getFavoriteAnimeUseCase: GetFavoriteAnimeUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getFavoriteAnimeUseCase: GetFavoriteAnimeUseCase) {
        self.getFavoriteAnimeUseCase = getFavoriteAnimeUseCase
    }

    func reload() {
        isLoading = true
        getFavoriteAnimeUseCase.execute(())
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] list in
                self?.favorites = list
            }
            .store(in: &cancellables)
    }
}
