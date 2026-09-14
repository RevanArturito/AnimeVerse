//
//  AnimeRemoteDataSource.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Alamofire
import Combine
import Foundation

protocol AnimeRemoteDataSource {
    func getTopAnime(page: Int) -> AnyPublisher<[AnimeDataDTO], Error>
    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetailDataDTO, Error>
}

final class AnimeRemoteDataSourceImpl: AnimeRemoteDataSource {

    func getTopAnime(page: Int) -> AnyPublisher<[AnimeDataDTO], Error> {
        request(url: AnimeAPI.topAnime(page: page), as: AnimeListResponse.self)
            .map(\.data)
            .eraseToAnyPublisher()
    }

    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetailDataDTO, Error> {
        request(url: AnimeAPI.detail(id: id), as: AnimeDetailResponse.self)
            .map(\.data)
            .eraseToAnyPublisher()
    }

    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return Session(configuration: config)
    }()

    private func request<T: Decodable>(url: String, as type: T.Type) -> AnyPublisher<T, Error> {
        Deferred {
            Future<T, Error> { [weak self] promise in
                self?.session.request(url)
                    .validate()
                    .responseDecodable(of: T.self) { response in
                        switch response.result {
                        case .success(let value):
                            promise(.success(value))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
            }
        }
        .retry(2)
        .eraseToAnyPublisher()
    }
}
