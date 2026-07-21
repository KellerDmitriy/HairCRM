//
//  AirbnbCerealFontModifier.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//


import SwiftUI

struct AirbnbCerealFontModifier: ViewModifier {
    let type: AirbnbCerealFont
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(type.rawValue, size: size))
    }
}