//
//  AddProductSheet.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 03.08.2026.
//

import SwiftUI
import SwiftData

struct AddProductSheet: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @ObservedObject
    var viewModel: InventoryViewModel
    
    let category: ProductCategory
    
    @Query(sort: \Brand.name)
    private var brands: [Brand]
    
    @State private var selectedBrand: Brand? = nil
    
    @State private var series = ""
    @State private var name = ""
    @State private var quantity = ""
    @State private var purchasePrice = ""
    @State private var unit: ProductUnit = .gram
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let titleFontSize: CGFloat = 20
        static let maxToolbarWidth: CGFloat = UIScreen.main.bounds.width * 0.6
        static let maxToolbarHeight: CGFloat = 44
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(Resources.Text.general) {
                        
                        TextField(
                            Resources.Text.nameProduct,
                            text: $name
                        )
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        
                        
                        TextField(
                            Resources.Text.series,
                            text: $series
                        )
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        
                        Picker(
                            Resources.Text.brand,
                            selection: $selectedBrand
                        ) {
                            
                            ForEach(brands) { brand in
                                Text(brand.name)
                                    .tag(brand)
                            }
                        }
                        .pickerStyle(.menu)
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        .foregroundStyle(.secondary).opacity(0.6)
                        .tint(.secondary)
                    }
                    
                    Section(Resources.Text.store.capitalized) {
                        
                        TextField(
                            Resources.Text.cost,
                            text: $purchasePrice
                        )
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        .keyboardType(.decimalPad)
                        
                        TextField(
                            Resources.Text.quantity,
                            text: $quantity
                        )
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        .keyboardType(.decimalPad)
                        
                        Picker(
                            "",
                            selection: $unit
                        ) {
                            
                            ForEach(ProductUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                                    .tag(unit)
                            }
                        }
                        .pickerStyle(.palette)
                        .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                        .foregroundStyle(.secondary).opacity(0.6)
                        .tint(.secondary)
                        
                    }
                    Button( Resources.Text.addNew) {
                        addProduct()
                    }
                    
                }
                .background(.appBackground)
                
            }
            .navigationTitle(Resources.Text.addProduct)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(Resources.Text.cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button(Resources.Text.addNew) {
                        
                        addProduct()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .alert(item: $viewModel.appError) { error in
                Alert(
                    title: Text(Resources.Text.error),
                    message:  Text(error.localizedDescription),
                    dismissButton: .default(Text(Resources.Text.ok))
                )
            }
        }
        .presentationDetents([.large, .large])
    }
    
//    Helpers
    private func addProduct() {
        
        let cleanName = name.cleaned
        
        guard !cleanName.isEmpty else {
            return
        }
        
        let quantityValue = Double(
            quantity.replacingOccurrences(of: ",", with: ".")
        ) ?? 0
        
        let purchasePriceValue = Double(
            purchasePrice.replacingOccurrences(of: ",", with: ".")
        ) ?? 0
        
        guard quantityValue > 0 else {
            return
        }
        
        guard purchasePriceValue > 0 else {
            return
        }
        
        let cost = purchasePriceValue / quantityValue
        
        let product = Product(
            category: category,
            brand: selectedBrand,
            series: series.cleaned.isEmpty
                ? nil
                : series.cleaned,
            name: cleanName,
            cost: cost,
            quantity: quantityValue,
            unit: unit,
            minimumQuantity: 1.0
        )
        
        viewModel.addProduct(product)
        dismiss()
    }
    
// расчитываем себестоимость
    private var calculatedCost: Double {
        let quantityValue = Double(
            quantity.replacingOccurrences(of: ",", with: ".")
        ) ?? 0
        
        let priceValue = Double(
            purchasePrice.replacingOccurrences(of: ",", with: ".")
        ) ?? 0
        
        guard quantityValue > 0 else {
            return 0
        }
        
        return priceValue / quantityValue
    }
}


#Preview {
    let container = try! ModelContainer(
        for:
            Product.self,
        ProductCategory.self,
        ProductGroup.self,
        Brand.self
        ,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let appContainer = AppContainer(
        context: container.mainContext
    )
    
    
    AddProductSheet(
        viewModel: InventoryViewModel(inventoryService:  appContainer.inventoryService), category: ProductCategory.init(name: "Краситель")
    )
}
