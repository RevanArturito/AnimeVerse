//
//  DetailView.swift
//  AnimeVerse
//

import SwiftUI
import Kingfisher
import Common

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel

    var body: some View {
        ZStack {
            Color.bgPrimary.ignoresSafeArea()

            if viewModel.isLoading && viewModel.detail == nil {
                ProgressView().tint(.accentPink)
            } else if let detail = viewModel.detail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        KFImage(URL(string: detail.imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 260)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 16))

                        Text(detail.title)
                            .font(.heading(24))
                            .foregroundColor(.textPrimary)

                        Text("\(detail.score.map { String(format: "★ %.1f", $0) } ?? "★ -")  •  \(detail.episodes.map(String.init) ?? "-") eps  •  \(detail.status)")
                            .font(.body(14))
                            .foregroundColor(.accentPink)

                        Text(detail.genres.joined(separator: ", "))
                            .font(.body(13))
                            .foregroundColor(.textSecondary)

                        Text("detail.synopsis".localized)
                            .font(.heading(18))
                            .foregroundColor(.textPrimary)
                            .padding(.top, 4)

                        Text(detail.synopsis)
                            .font(.body(15))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle(viewModel.detail?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: (viewModel.detail?.isFavorite ?? false) ? "heart.fill" : "heart")
                        .foregroundColor(.accentPink)
                }
            }
        }
        .onAppear { viewModel.onAppear() }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}
