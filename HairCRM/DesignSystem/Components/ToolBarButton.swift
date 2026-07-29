//
//  ToolBarButton.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//


import SwiftUI

struct ToolBarButton: View {
    
    // MARK: - Properties
    let icon: ImageResource
    let action: () -> Void
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let cornerRadius: CGFloat = 10
        static let backgroundOpacity: Double = 0.3
        static let buttonSize: CGFloat = 36
        static let iconSize: CGFloat = 24
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            ZStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                    .foregroundStyle(.appForegroundStyle)
            }
        }
    }
}
