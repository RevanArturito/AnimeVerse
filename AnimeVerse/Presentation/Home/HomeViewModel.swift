//
//  HomeViewModel.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var searchQuery: String = ""

    @Published private(set) var animeList: [Anime] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    private let getTopAnimeUseCase: GetTopAnimeUseCase
    private let searchAnimeUseCase: SearchAnimeUseCase
    private var cancellables = Set<AnyCancellable>()

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let pullToRefreshSubject = PassthroughSubject<Void, Never>()

    init(getTopAnimeUseCase: GetTopAnimeUseCase, searchAnimeUseCase: SearchAnimeUseCase) {
        self.getTopAnimeUseCase = getTopAnimeUseCase
        self.searchAnimeUseCase = searchAnimeUseCase
        bind()
    }

    func onAppear() { viewDidLoadSubject.send(()) }
    func refresh() { pullToRefreshSubject.send(()) }

    private func bind() {
        let load = Publishers.Merge(viewDidLoadSubject, pullToRefreshSubject)
            .map { "" }
        
        let search = $searchQuery
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .dropFirst()

        Publishers.Merge(load, search)
            .handleEvents(receiveOutput: { [weak self] _ in self?.isLoading = true })
            .map { [weak self] query -> AnyPublisher<[Anime], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                let source: AnyPublisher<[Anime], Error> = query.trimmingCharacters(in: .whitespaces).isEmpty
                    ? self.getTopAnimeUseCase.execute(page: 1)
                    : self.searchAnimeUseCase.execute(query: query)

                return source
                    .catch { [weak self] error -> Just<[Anime]> in
                        self?.errorMessage = error.localizedDescription
                        return Just([])
                    }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .handleEvents(receiveOutput: { [weak self] _ in self?.isLoading = false })
            .receive(on: RunLoop.main)
            .assign(to: &$animeList)
    }
}
