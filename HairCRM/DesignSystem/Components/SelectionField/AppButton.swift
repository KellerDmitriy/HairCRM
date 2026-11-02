//
//  AppButton.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 02.11.2026.
//

import SwiftUI

struct AppButton: View {
    let title: String
    let onAction: () -> Void
    
    var body: some View {
        Button {
            onAction()
        } label: {
            ZStack {
                Capsule()
                    .foregroundStyle(.appForegroundStyle)
                    .frame(width: 200, height: 35)
                Text(title)
                    .airbnbCerealFont(.medium, size: 14)
                    .foregroundStyle(.appBackground)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AppButton(title: "Ok", onAction: {})
}
