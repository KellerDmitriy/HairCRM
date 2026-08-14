//
//  AppFormCard.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 14.08.2026.
//


import SwiftUI

struct AppFormCard<Content: View>: View {
    
    private let content: Content
    
    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(.appBackground)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        .white.opacity(0.08),
                        lineWidth: 1
                    )
            }
    }
}

