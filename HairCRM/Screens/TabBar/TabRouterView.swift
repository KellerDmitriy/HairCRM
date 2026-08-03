//
//  TabRouterView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import SwiftUI

struct TabRouterView: View {
    let selectedTab: Tab

    var body: some View {
        switch selectedTab {
        case .home:
            NavigationStack {
                HomeScreen()
            }

        case .materials:
            NavigationStack {
                InventoryScreen()
            }

        case .calculator:
            NavigationStack {
                CalculatorScreen()
            }

        case .clients:
            NavigationStack {
                ClientsScreen()
            }

        case .profile:
            NavigationStack {
                ProfileScreen()
            }
        }
    }
}
