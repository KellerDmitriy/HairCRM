//
//  AppCloseButton.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 14.08.2026.
//

import SwiftUI

struct AppCloseButton: View {
    
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(.secondary)
        }
    }
}
