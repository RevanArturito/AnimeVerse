//
//  AboutView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    Image("profile_photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentPink, lineWidth: 2))
                        .padding(.top, 24)

                    Text("Cokorda Arturito Revan Putra Diarta")
                        .font(.heading(22))
                        .foregroundColor(.textPrimary)

                    Text("iOS Developer")
                        .font(.body(14))
                        .foregroundColor(.accentPink)

                    Divider().background(Color.bgCard).padding(.vertical, 12)

                    VStack(alignment: .leading, spacing: 14) {
                        InfoRow(icon: "envelope.fill", text: "off.revan.arturito@gmail.com")
                        InfoRow(icon: "graduationcap.fill", text: "dicoding.com/users/revanarturito/academies")
                    }
                    .padding(.horizontal, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 24)
            }
            .background(Color.bgPrimary.ignoresSafeArea())
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct InfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.accentPink)
                .frame(width: 20)
            Text(text)
                .font(.body(14))
                .foregroundColor(.textPrimary)
        }
    }
}
