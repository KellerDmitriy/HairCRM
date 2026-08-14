//
//  BrandCard.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//

import SwiftUI

struct BrandCard: View {

    let brand: Brand
    
    // MARK: - Body
    var body: some View {

        VStack(spacing: 12) {

            if let image = brand.imageData,
               let uiImage = UIImage(data: image) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            } else {
                Image(systemName: "shippingbox")
                    .font(.system(size: 70))
                    .foregroundStyle(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Text(brand.name)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(.appBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
