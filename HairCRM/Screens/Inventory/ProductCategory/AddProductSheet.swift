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
    
    @State private var unit: ProductUnit = .gram
    @State private var showBrandSelection = false
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let titleFontSize: CGFloat = 20
        static let maxToolbarWidth: CGFloat = UIScreen.main.bounds.width * 0.6
        static let maxToolbarHeight: CGFloat = 44
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
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
                    
                    SelectionField(
                        title: Resources.Text.brand,
                        value: selectedBrand?.name
                    ) {
                        showBrandSelection = true
                    }
                   
                }
                
                Section(Resources.Text.inventory) {
                    
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
                    let product = Product(
                        category: category,
                        brand: selectedBrand,
                        series: series.isEmpty ? nil : series,
                        name: name,
                        quantity: Double(quantity.replacingOccurrences(of: ",", with: ".")) ?? 0,
                        unit: unit,
                        minimumQuantity: 1
                    )
                    viewModel.addProduct(product)
                    dismiss()
                }
              
            }
            .background(.appBackground)
        }
        
        .sheet(
            isPresented: $showBrandSelection
        ) {
            
            SelectionSheet(
                title: "Бренды",
                items: brands,
                selectedItem: $selectedBrand,
                displayName: {
                    $0.name
                },
                onCreate: { name in
                    viewModel.addBrand(name: name)
                }
            )
            .padding(.horizontal)
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
                    
                    let product = Product(
                        category: category,
                        brand: selectedBrand,
                        series: series.isEmpty ? nil : series,
                        name: name,
                        quantity: Double(quantity) ?? 0,
                        unit: unit,
                        minimumQuantity: 1.0
                    )
                    
                    viewModel.addProduct(product)
                    
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
        }
        .presentationDetents([.medium, .large])
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
