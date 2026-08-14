//
//  ContentView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext)
    private var modelContext

    @State
    private var appContainer: AppContainer?

    @State
    private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            if let appContainer {
                TabRouterView(selectedTab: selectedTab)
                    .environment(
                        \.appContainer,
                        appContainer
                    )

                TabbarView(
                    selectedTab: $selectedTab,
                    switchTab: switchTab
                )
                .ignoresSafeArea(.keyboard)
            } else {
                ProgressView()
            }
        }
        .task {
            if appContainer == nil {
                appContainer = AppContainer(context: modelContext)
            }
        }
    }

    func switchTab(_ tab: Tab) {
        selectedTab = tab
    }
}

#Preview {
    ContentView()
}
