//
//  LocalizationManager.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation
import Combine

public final class LocalizationManager: ObservableObject {
    public static let shared = LocalizationManager()

    @Published public private(set) var currentLanguage: String

    private init() {
        currentLanguage = UserDefaults.standard.string(forKey: "app_language") ?? "id"
    }

    public func setLanguage(_ code: String) {
        currentLanguage = code
        UserDefaults.standard.set(code, forKey: "app_language")
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
