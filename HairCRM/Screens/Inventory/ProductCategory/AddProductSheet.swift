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
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                addProductSection()
                addStockSection()
                
                AppAddNewButton(
                    title: Resources.Text.addNew,
                    value: nil,
                    action: addProduct
                )
            }
            
            .navigationTitle(Resources.Text.addProduct)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    AppCloseButton { dismiss()}
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    AppAddButton { addProduct()}
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
    
    // MARK: - Categories Section
    private func addProductSection() -> some View {
        AppFormCard {
            VStack(alignment: .leading, spacing: 8) {
                AppTextField(
                    title:Resources.Text.nameProduct,
                    text: $name
                )
                AppTextField(
                    title: Resources.Text.series,
                    text: $series
                )
                
                Picker(
                    Resources.Text.brand,
                    selection: $selectedBrand
                ) {
                    Text(Resources.Text.notSelected)
                        .tag(nil as Brand?)
                    
                    ForEach(brands) { brand in
                        Text(brand.name)
                            .tag(brand)
                    }
                }
                .pickerStyle(.menu)
                .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.titleFontSize)
                
                .tint(.secondary)
                .foregroundStyle(.secondary).opacity(0.6)
                .padding(.horizontal)

            }
        }
    }
    
    private func addStockSection() -> some View {
        
        AppFormCard {
            VStack(alignment: .leading, spacing: 8) {
                AppTextField(
                    title: Resources.Text.cost,
                    text: $purchasePrice,
                    keyboardType: .decimalPad
                )
                AppTextField(
                    title:Resources.Text.quantity,
                    text: $quantity,
                    keyboardType: .decimalPad
                )
                
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
        }
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
    
    NavigationView {
        AddProductSheet(
            viewModel: InventoryViewModel(inventoryService:  appContainer.inventoryService), category: ProductCategory.init(name: "Краситель")
        )
    }
}
