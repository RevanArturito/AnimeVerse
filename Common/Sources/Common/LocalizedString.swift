//
//  LocalizedString.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
