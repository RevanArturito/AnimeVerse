//
//  AnimeRemoteDataSource.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Alamofire
import Combine

protocol AnimeRemoteDataSource {
    func getTopAnime(page: Int) -> AnyPublisher<[AnimeDataDTO], Error>
    func searchAnime(query: String) -> AnyPublisher<[AnimeDataDTO], Error>
    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetailDataDTO, Error>
}

final class AnimeRemoteDataSourceImpl: AnimeRemoteDataSource {

    func getTopAnime(page: Int) -> AnyPublisher<[AnimeDataDTO], Error> {
        request(url: AnimeAPI.topAnime(page: page), as: AnimeListResponse.self)
            .map(\.data)
            .eraseToAnyPublisher()
    }

    func searchAnime(query: String) -> AnyPublisher<[AnimeDataDTO], Error> {
        request(url: AnimeAPI.search(query: query), as: AnimeSearchResponse.self)
            .map(\.data)
            .eraseToAnyPublisher()
    }

    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetailDataDTO, Error> {
        request(url: AnimeAPI.detail(id: id), as: AnimeDetailResponse.self)
            .map(\.data)
            .eraseToAnyPublisher()
    }

    private func request<T: Decodable>(url: String, as type: T.Type) -> AnyPublisher<T, Error> {
        Deferred {
            Future<T, Error> { promise in
                AF.request(url)
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
        .eraseToAnyPublisher()
    }
}
