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
        ZStack {
            HStack(spacing: 12)  {
                productImage
                
                if let productSeries = product.series {
                    Text("\(productSeries):")
                }
                Text(product.name)
                
                Spacer()
                
                quantityView
                    .padding()
            }
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
        
        VStack(alignment: .trailing, spacing: 4) {
            Text(
                "\(product.quantity.formatted()) \(product.unit.rawValue)"
            )
            .font(.headline)
            
            
            Text("остаток")
                .font(.caption)
                .foregroundStyle(.secondary)
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
            
            quantity: 8,
            
            unit: .piece,
            minimumQuantity: 1.0,
            dateOfPurchase: Date(),
            imageData: nil
        )
    )
    .padding()
}
