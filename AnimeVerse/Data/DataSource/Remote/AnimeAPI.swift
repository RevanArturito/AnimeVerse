//
//  AnimeAPI.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import Foundation

enum AnimeAPI {
    static var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
              !url.isEmpty else {
            fatalError("API_BASE_URL tidak ditemukan di Info.plist — pastikan Secrets.xcconfig sudah di-set sebagai Configuration file.")
        }
        return url
    }

    static func topAnime(page: Int) -> String {
        "\(baseURL)/top/anime?page=\(page)"
    }

    static func detail(id: Int) -> String {
        "\(baseURL)/anime/\(id)/full"
    }
}
