//
//  AboutView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 14/09/26.
//

import SwiftUI
import Common

public struct AboutView: View {
    @ObservedObject private var localization = LocalizationManager.shared
    @State private var showRestartAlert = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
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
                    
                    Picker("about.language_toggle".localized, selection: Binding(
                        get: { localization.currentLanguage },
                        set: { newValue in
                            localization.setLanguage(newValue)
                            showRestartAlert = true
                        }
                    )) {
                        Text("Bahasa Indonesia").tag("id")
                        Text("English").tag("en")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 24)
                }
            }
            .background(Color.bgPrimary.ignoresSafeArea())
            .navigationTitle("about.title".localized)
            .alert("Restart aplikasi untuk menerapkan bahasa baru", isPresented: $showRestartAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .navigationViewStyle(.stack)
    }
}
