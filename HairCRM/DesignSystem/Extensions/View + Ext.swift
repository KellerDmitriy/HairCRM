//
//  View + Ext.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//


import SwiftUI

extension View {
    func airbnbCerealFont(_ type: AirbnbCerealFont, size: CGFloat = 16) -> some View {
        modifier(AirbnbCerealFontModifier(type: type, size: size))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
