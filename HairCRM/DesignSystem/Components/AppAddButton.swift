//
//  AppAddButton.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 28.10.2026.
//


import SwiftUI

struct AppAddButton: View {
    
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "checkmark")
                .foregroundStyle(.secondary)
        }
    }
}