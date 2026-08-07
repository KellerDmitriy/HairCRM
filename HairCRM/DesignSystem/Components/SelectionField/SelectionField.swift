//
//  SelectionField.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 06.08.2026.
//


import SwiftUI

struct SelectionField: View {

    let title: String
    let value: String?

    var action: () -> Void
    
    private struct Drawing {
        static let titleFontSize: CGFloat = 20
        static let spacing: CGFloat = 10
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
    }
}
