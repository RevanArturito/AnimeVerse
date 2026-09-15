//
//  HomeViewModel.swift
//  AnimeVerse
//

import Combine
import Foundation
import Core

final class HomeViewModel: ObservableObject {
    @Published var searchQuery: String = ""

    @Published private(set) var animeList: [Anime] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    private var allAnime: [Anime] = []

    private let getTopAnimeUseCase: GetTopAnimeUseCase
    private var cancellables = Set<AnyCancellable>()

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let pullToRefreshSubject = PassthroughSubject<Void, Never>()

    init(getTopAnimeUseCase: GetTopAnimeUseCase) {
        self.getTopAnimeUseCase = getTopAnimeUseCase
        bind()
    }

    func onAppear() { viewDidLoadSubject.send(()) }
    func refresh() { pullToRefreshSubject.send(()) }

    private func bind() {
        Publishers.Merge(viewDidLoadSubject, pullToRefreshSubject)
            .handleEvents(receiveOutput: { [weak self] _ in self?.isLoading = true })
            .flatMap { [weak self] _ -> AnyPublisher<[Anime], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                return self.getTopAnimeUseCase.execute(1)
                    .catch { [weak self] _ -> Just<[Anime]> in
                        self?.errorMessage = "Gagal memuat data, coba lagi."
                        return Just([])
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] list in
                self?.allAnime = list
                self?.applyFilter()
                self?.isLoading = false
            }
            .store(in: &cancellables)

        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.applyFilter()
            }
            .store(in: &cancellables)
    }

    private func applyFilter() {
        let query = searchQuery.trimmingCharacters(in: .whitespaces).lowercased()
        if query.isEmpty {
            animeList = allAnime
        } else {
            animeList = allAnime.filter { $0.title.lowercased().contains(query) }
        }
    }
}
