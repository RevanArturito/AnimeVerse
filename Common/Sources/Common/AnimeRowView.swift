//
//  AnimeRowView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI
import Kingfisher

public struct AnimeRowView: View {
    private let anime: Anime

    public init(anime: Anime) {
        self.anime = anime
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            KFImage(URL(string: anime.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 6) {
                Text(anime.title)
                    .font(.heading(16))
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                Text(anime.status)
                    .font(.body(13))
                    .foregroundColor(.textSecondary)
                Spacer(minLength: 0)
                if let score = anime.score {
                    Text(String(format: "%.1f", score))
                        .font(.heading(12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.accentPink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            Spacer()
            Image(systemName: anime.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.accentPink)
        }
        .padding(12)
        .frame(minHeight: 110)
        .background(Color.bgCard)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
    }
}
