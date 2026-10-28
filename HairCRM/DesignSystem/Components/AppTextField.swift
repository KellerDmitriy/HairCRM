//
//  AppTextField.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 14.08.2026.
//


import SwiftUI

struct AppTextField: View {

    let title: String

    @Binding var text: String

    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .sentences
    var autocorrectionDisabled = false
    var axis: Axis = .horizontal

    var body: some View {
        TextField(
            title,
            text: $text,
            axis: axis
        )
        .airbnbCerealFont(
            AirbnbCerealFont.medium,
            size: 16
        )
        .keyboardType(keyboardType)
        .textContentType(textContentType)
        .textInputAutocapitalization(autocapitalization)
        .autocorrectionDisabled(autocorrectionDisabled)
        .padding(.horizontal, 14)
        .frame(minHeight: 48)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.appBackground)
        )

        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(
                    .appForegroundStyle.opacity(0.2),
                    lineWidth: 1.5
                )
        }
    }
}
