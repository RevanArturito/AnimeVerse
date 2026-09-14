//
//  DetailViewModel.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine
import Foundation

final class DetailViewModel: ObservableObject {
    let animeId: Int

    @Published private(set) var detail: AnimeDetail?
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    private let getAnimeDetailUseCase: GetAnimeDetailUseCase
    private let addFavoriteUseCase: AddFavoriteAnimeUseCase
    private let removeFavoriteUseCase: RemoveFavoriteAnimeUseCase
    private var cancellables = Set<AnyCancellable>()

    init(animeId: Int,
         getAnimeDetailUseCase: GetAnimeDetailUseCase,
         addFavoriteUseCase: AddFavoriteAnimeUseCase,
         removeFavoriteUseCase: RemoveFavoriteAnimeUseCase) {
        self.animeId = animeId
        self.getAnimeDetailUseCase = getAnimeDetailUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
    }

    func onAppear() {
        guard detail == nil else { return } 
        isLoading = true
        getAnimeDetailUseCase.execute(id: animeId)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "Gagal memuat data, coba lagi."
                }
            } receiveValue: { [weak self] detail in
                self?.detail = detail
            }
            .store(in: &cancellables)
    }

    func toggleFavorite() {
        guard let current = detail else { return }
        let action = current.isFavorite
            ? removeFavoriteUseCase.execute(id: current.id)
            : addFavoriteUseCase.execute(anime: current)

        action
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "Gagal memuat data, coba lagi."
                }
            } receiveValue: { [weak self] _ in
                guard var updated = self?.detail else { return }
                updated.isFavorite.toggle()
                self?.detail = updated
            }
            .store(in: &cancellables)
    }
}
