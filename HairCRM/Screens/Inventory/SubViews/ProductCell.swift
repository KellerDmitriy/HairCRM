//
//  ProductCell.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 29.07.2026.
//

import SwiftUI

struct ProductCell: View {
    
    let product: Product
    
    // MARK: - Body
    var body: some View {
        AppFormCard {
            HStack(spacing: 12) {
                
                VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .airbnbCerealFont(AirbnbCerealFont.book, size: 20)
                    
                    if let series = product.series {
                        Text(series)
                            .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                            .foregroundStyle(.secondary)
                    }
                    
                    if let brand = product.brand {
                        Text(brand.name)
                            .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                VStack(alignment: .center, spacing: 4) {
                    quantityView
                    productImage
                }
            }
        }
        .padding(.vertical, 8)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .listRowBackground(Color.clear)
    }
    
    //    MARK: Image
    private var productImage: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.searchBarPlaceholder)
            .frame(width: 50, height: 50)
            .overlay {
                Image(systemName: "shippingbox")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
    }
    
    // MARK: - Quantity
    private var quantityView: some View {
        
        VStack(alignment: .center, spacing: 2) {
            Text(Resources.Text.balance)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(
                "\(product.quantity.formatted()) \(product.unit.rawValue)"
            )
            .font(.headline)
        }
    }
}

#Preview {
    
    ProductCell(
        
        product: Product(
            category: ProductCategory.init(
                name: "краска"
            ),
            brand: Brand(
                name: "Goldwell"
            ),
            
            series: "Topchic",
            
            name: "7NA",
            cost: 0.0,
            
            quantity: 8,
            
            unit: .piece,
            minimumQuantity: 1.0,
            dateOfPurchase: Date(),
            imageData: nil
        )
    )
    .padding()
}
