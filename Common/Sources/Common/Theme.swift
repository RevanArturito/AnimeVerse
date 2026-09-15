//
//  Theme.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI

public extension Color {
    static let bgPrimary = Color(red: 0.055, green: 0.059, blue: 0.075)
    static let bgCard = Color(red: 0.102, green: 0.110, blue: 0.133)
    static let accentPink = Color(red: 1.0, green: 0.231, blue: 0.363)
    static let textPrimary = Color(white: 0.96)
    static let textSecondary = Color(red: 0.604, green: 0.612, blue: 0.647)
}

public extension Font {
    static func heading(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }
    static func body(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular)
    }
}
