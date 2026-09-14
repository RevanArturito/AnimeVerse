//
//  AnimeRepositories.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Combine

protocol AnimeRepository {
    func getTopAnime(page: Int) -> AnyPublisher<[Anime], Error>
    func searchAnime(query: String) -> AnyPublisher<[Anime], Error>
    func getAnimeDetail(id: Int) -> AnyPublisher<AnimeDetail, Error>

    func getFavoriteAnime() -> AnyPublisher<[Anime], Error>
    func addFavorite(_ anime: AnimeDetail) -> AnyPublisher<Void, Error>
    func removeFavorite(id: Int) -> AnyPublisher<Void, Error>
    func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
