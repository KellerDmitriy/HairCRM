//
//  TabContent.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import SwiftUI

struct TabContent: View {
    let selectedTab: Tab
    
    var body: some View {
        Group {
            switch selectedTab {
            case .home:
                HomeScreen()
            case .materials:
               MaterialsScreen()
            case .calculator:
                CalculatorScreen()
            case .clients:
                ClientsScreen()
            case .profile:
                ProfileScreen()
            }
        }
    }
}
