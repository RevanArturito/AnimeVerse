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

    private var mockRepository: MockAnimeRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockAnimeRepository()
        cancellables = []
    }

    override func tearDown() {
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: GetTopAnimeUseCase Tests

    func test_getTopAnimeUseCase_success() {
        let expectedAnimes = [
            Anime(id: 1, title: "Frieren", imageUrl: "https://example.com/frieren.jpg", score: 9.3, episodes: 28, status: "Finished Airing", isFavorite: false),
            Anime(id: 2, title: "Attack on Titan", imageUrl: "https://example.com/aot.jpg", score: 9.0, episodes: 25, status: "Finished Airing", isFavorite: true)
        ]
        mockRepository.getTopAnimeResult = .success(expectedAnimes)
        let useCase = GetTopAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Get top anime success")
        var receivedAnimes: [Anime]?

        useCase.execute(page: 1)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil, bukan failure")
                }
            } receiveValue: { animes in
                receivedAnimes = animes
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedAnimes, expectedAnimes)
        XCTAssertEqual(mockRepository.passedPage, 1)
    }

    func test_getTopAnimeUseCase_failure() {
        mockRepository.getTopAnimeResult = .failure(TestError.network)
        let useCase = GetTopAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Get top anime failure")
        var receivedError: Error?

        useCase.execute(page: 2)
            .sink { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Harusnya gagal, bukan success")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(receivedError)
        XCTAssertEqual(mockRepository.passedPage, 2)
    }

    // MARK: GetAnimeDetailUseCase Tests

    func test_getAnimeDetailUseCase_success() {
        let expectedDetail = AnimeDetail(
            id: 1,
            title: "Frieren",
            imageUrl: "https://example.com/frieren.jpg",
            synopsis: "Elf mage journey",
            score: 9.3,
            episodes: 28,
            status: "Finished Airing",
            genres: ["Adventure", "Fantasy"],
            studios: ["Madhouse"],
            duration: "24 min per ep",
            rating: "PG-13",
            isFavorite: false
        )
        mockRepository.getAnimeDetailResult = .success(expectedDetail)
        let useCase = GetAnimeDetailUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Get anime detail success")
        var receivedDetail: AnimeDetail?

        useCase.execute(id: 1)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil")
                }
            } receiveValue: { detail in
                receivedDetail = detail
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedDetail, expectedDetail)
        XCTAssertEqual(mockRepository.passedAnimeId, 1)
    }

    func test_getAnimeDetailUseCase_failure() {
        mockRepository.getAnimeDetailResult = .failure(TestError.notFound)
        let useCase = GetAnimeDetailUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Get anime detail failure")
        var receivedError: Error?

        useCase.execute(id: 999)
            .sink { completion in
                if case .failure(let error) = completion {
                    receivedError = error
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                XCTFail("Harusnya gagal")
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(receivedError)
        XCTAssertEqual(mockRepository.passedAnimeId, 999)
    }

    // MARK: GetFavoriteAnimeUseCase Tests

    func test_getFavoriteAnimeUseCase_success() {
        let favorites = [
            Anime(id: 10, title: "Steins;Gate", imageUrl: "https://example.com/sg.jpg", score: 9.1, episodes: 24, status: "Finished Airing", isFavorite: true)
        ]
        mockRepository.getFavoriteAnimeResult = .success(favorites)
        let useCase = GetFavoriteAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Get favorite anime success")
        var receivedFavorites: [Anime]?

        useCase.execute()
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil")
                }
            } receiveValue: { list in
                receivedFavorites = list
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedFavorites, favorites)
    }

    // MARK: AddFavoriteAnimeUseCase Tests

    func test_addFavoriteAnimeUseCase_success() {
        let animeToAdd = AnimeDetail(
            id: 5,
            title: "Hunter x Hunter",
            imageUrl: "https://example.com/hxh.jpg",
            synopsis: "Gon journey",
            score: 9.0,
            episodes: 148,
            status: "Finished Airing",
            genres: ["Action", "Adventure"],
            studios: ["Madhouse"],
            duration: "24 min per ep",
            rating: "PG-13",
            isFavorite: false
        )
        mockRepository.addFavoriteResult = .success(())
        let useCase = AddFavoriteAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Add favorite success")

        useCase.execute(anime: animeToAdd)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil")
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(mockRepository.passedAnimeDetail?.id, 5)
    }

    // MARK: RemoveFavoriteAnimeUseCase Tests

    func test_removeFavoriteAnimeUseCase_success() {
        mockRepository.removeFavoriteResult = .success(())
        let useCase = RemoveFavoriteAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Remove favorite success")

        useCase.execute(id: 5)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil")
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(mockRepository.passedAnimeId, 5)
    }

    // MARK: IsFavoriteAnimeUseCase Tests

    func test_isFavoriteAnimeUseCase_returnsTrue() {
        mockRepository.isFavoriteResult = .success(true)
        let useCase = IsFavoriteAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Is favorite returns true")
        var isFav: Bool?

        useCase.execute(id: 1)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil")
                }
            } receiveValue: { value in
                isFav = value
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(isFav, true)
        XCTAssertEqual(mockRepository.passedAnimeId, 1)
    }

    func test_isFavoriteAnimeUseCase_returnsFalse() {
        mockRepository.isFavoriteResult = .success(false)
        let useCase = IsFavoriteAnimeUseCaseImpl(repository: mockRepository)

        let expectation = expectation(description: "Is favorite returns false")
        var isFav: Bool?

        useCase.execute(id: 2)
            .sink { completion in
                if case .failure = completion {
                    XCTFail("Harusnya berhasil")
                }
            } receiveValue: { value in
                isFav = value
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(isFav, false)
        XCTAssertEqual(mockRepository.passedAnimeId, 2)
    }
}

// MARK: Test Helpers & Mock Repository

private enum TestError: Error, Equatable {
    case network
    case notFound
}

private final class MockAnimeRepository: AnimeRepository {
    var getTopAnimeResult: Result<[Anime], Error> = .success([])
    var getAnimeDetailResult: Result<AnimeDetail, Error> = .failure(TestError.notFound)
    var getFavoriteAnimeResult: Result<[Anime], Error> = .success([])
    var addFavoriteResult: Result<Void, Error> = .success(())
    var removeFavoriteResult: Result<Void, Error> = .success(())
    var isFavoriteResult: Result<Bool, Error> = .success(false)

    var passedPage: Int?
    var passedAnimeId: Int?
    var passedAnimeDetail: AnimeDetail?

    func getTopAnime(page: Int) -> AnyPublisher<[Anime], Error> {
        passedPage = page
        return getTopAnimeResult.publisher.eraseToAnyPublisher()
    }

    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetail, Error> {
        passedAnimeId = id
        return getAnimeDetailResult.publisher.eraseToAnyPublisher()
    }

    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        return getFavoriteAnimeResult.publisher.eraseToAnyPublisher()
    }

    func addFavorite(_ anime: AnimeDetail) -> AnyPublisher<Void, Error> {
        passedAnimeDetail = anime
        return addFavoriteResult.publisher.eraseToAnyPublisher()
    }

    func removeFavorite(id: Int) -> AnyPublisher<Void, Error> {
        passedAnimeId = id
        return removeFavoriteResult.publisher.eraseToAnyPublisher()
    }

    func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        passedAnimeId = id
        return isFavoriteResult.publisher.eraseToAnyPublisher()
    }
}
