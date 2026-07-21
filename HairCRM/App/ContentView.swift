//
//  ContentView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TabContent(selectedTab: selectedTab)
                VStack {
                    Spacer()
                    TabbarView(
                        selectedTab: $selectedTab,
                        switchTab: switchTab
                    )
                   
                }
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
