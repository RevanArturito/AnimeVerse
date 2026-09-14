//
//  AnimeVerseTests.swift
//  AnimeVerseTests
//
//  Created by Revan Arturito on 14/09/26.
//

import XCTest
import Combine
@testable import AnimeVerse

final class AnimeVerseTests: XCTestCase {

    private var mockRepo: MockAnimeRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepo = MockAnimeRepository()
        cancellables = []
    }

    override func tearDown() {
        mockRepo = nil
        cancellables = nil
        super.tearDown()
    }

    func test_getTopAnimeUseCase() {
        let expected = [Anime(id: 1, title: "Frieren", imageUrl: "", score: 9.3, episodes: 28, status: "Airing")]
        mockRepo.topAnimeResult = .success(expected)

        let exp = expectation(description: "Fetch Top Anime")
        GetTopAnimeUseCaseImpl(repository: mockRepo).execute(page: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                XCTAssertEqual(result, expected)
                exp.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_getAnimeDetailUseCase() {
        let expected = AnimeDetail(id: 1, title: "Frieren", imageUrl: "", synopsis: "A mage", score: 9.3, episodes: 28, status: "Airing", genres: [], studios: [], duration: "", rating: "")
        mockRepo.detailResult = .success(expected)

        let exp = expectation(description: "Fetch Detail")
        GetAnimeDetailUseCaseImpl(repository: mockRepo).execute(id: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                XCTAssertEqual(result, expected)
                exp.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }

    func test_favoriteUseCases() {
        let anime = AnimeDetail(id: 1, title: "Frieren", imageUrl: "", synopsis: "", score: 9.3, episodes: 28, status: "", genres: [], studios: [], duration: "", rating: "")
        
        // Add
        let addExp = expectation(description: "Add Favorite")
        AddFavoriteAnimeUseCaseImpl(repository: mockRepo).execute(anime: anime)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in addExp.fulfill() })
            .store(in: &cancellables)

        // Is Favorite
        mockRepo.isFavoriteResult = .success(true)
        let isFavExp = expectation(description: "Check Favorite")
        IsFavoriteAnimeUseCaseImpl(repository: mockRepo).execute(id: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { isFav in
                XCTAssertTrue(isFav)
                isFavExp.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}

// MARK: Mock Repository Ringkas

private final class MockAnimeRepository: AnimeRepository {
    var topAnimeResult: Result<[Anime], Error> = .success([])
    var detailResult: Result<AnimeDetail, Error> = .failure(NSError(domain: "test", code: -1))
    var isFavoriteResult: Result<Bool, Error> = .success(false)

    func getTopAnime(page: Int) -> AnyPublisher<[Anime], Error> { topAnimeResult.publisher.eraseToAnyPublisher() }
    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetail, Error> { detailResult.publisher.eraseToAnyPublisher() }
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> { topAnimeResult.publisher.eraseToAnyPublisher() }
    func addFavorite(_ anime: AnimeDetail) -> AnyPublisher<Void, Error> { Just(()).setFailureType(to: Error.self).eraseToAnyPublisher() }
    func removeFavorite(id: Int) -> AnyPublisher<Void, Error> { Just(()).setFailureType(to: Error.self).eraseToAnyPublisher() }
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> { isFavoriteResult.publisher.eraseToAnyPublisher() }
}
