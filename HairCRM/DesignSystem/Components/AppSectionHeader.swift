//
//  AppSectionHeader.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 14.08.2026.
//

import SwiftUI

struct AppSectionHeader: View {

    let title: String

    @Binding var isExpanded: Bool

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
        } label: {
            HStack {
                Text(title)
                    .airbnbCerealFont(.medium, size: 20)
                    .foregroundStyle(.secondary)
                    .opacity(0.6)

                Image(
                    systemName: isExpanded
                    ? "chevron.up"
                    : "chevron.down"
                )
                .foregroundStyle(.secondary)

                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
