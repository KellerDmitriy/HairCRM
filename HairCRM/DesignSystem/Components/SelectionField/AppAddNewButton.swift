//
//  AppAddNewButton.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 06.08.2026.
//


import SwiftUI

struct AppAddNewButton: View {

    let title: String
    let value: String?

    var action: () -> Void
    
    private struct Drawing {
        static let titleFontSize: CGFloat = 16
        static let spacing: CGFloat = 16
    }
    
    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                HStack(spacing: Drawing.spacing) {
              
                    Text(title)
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        .foregroundStyle(.secondary)
                    Text(value ?? "")
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        .foregroundStyle(.secondary)
                }
                Spacer()

                Image(systemName: "plus")
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
        .background(.appBackground)
        .padding(8)
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(
                    .white.opacity(0.08),
                    lineWidth: 1
                )
        }
        
    }
}

#Preview {
    AppAddNewButton(title: "Добавить", value: "") {}
}
