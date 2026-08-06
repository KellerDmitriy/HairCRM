//
//  InventoryScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI
import SwiftData

struct InventoryScreen: View {
    @Environment(\.appContainer)
    private var container
    
    // MARK: - Body
    var body: some View {
        if let container {
            InventoryContent(
                viewModel: InventoryViewModel(
                    inventoryService: container.inventoryService
                )
            )
        }
    }
}

struct InventoryContent: View {
    
    @StateObject
    private var viewModel: InventoryViewModel
    
    @Query(
        sort: \ProductCategory.name
    )
    private var productCategory: [ProductCategory]
    
    @Query(sort: \Brand.name)
    private var brands: [Brand]
    
    @State private var showAddCategory = false
    @State private var showSuggestions = true
    @State private var showSearchFlow = false
    @State private var showBrandSelection = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Init
    init(viewModel: InventoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            categoriesSection()
             
            addBrandSection()
                .padding(.bottom, 16)

            brandsSection()

        }
        .padding(20)
        .padding(.top)
        
        .background(.appBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.white.opacity(0.08), lineWidth: 1)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolBarButton(icon: .plus) {  showAddCategory = true }
            }
            
            ToolbarItem(placement: .principal) {
                ToolBarTitleView(title: Resources.Text.materials.localized)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarButton(icon: .searchWhite) { showSearchFlow = true }
            }
        }
        
        .sheet(isPresented: $showAddCategory) {
            AddCategorySheet(viewModel: viewModel)
        }
    }
    
    
    // MARK: - Categories Section
    private func categoriesSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Resources.Text.categories)
                .airbnbCerealFont(.medium, size: 20)
                .foregroundStyle(.secondary).opacity(0.6)
            
            ForEach(productCategory) { category in
                NavigationLink {
                    ProductCategoryScreen(
                        viewModel: viewModel,
                        category: category
                    )
                } label: {
                    HStack {
                        Text(category.name)
                            .airbnbCerealFont(.medium, size: 15)
                        
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.appBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Add BrandSection
    private func addBrandSection() -> some View {
        
        SelectionField(
            title: Resources.Text.addNewBrand,
            value: nil
        ) {
            showBrandSelection = true
        }
        .shadow(radius: 12)
    }
    
    // MARK: - BrandsSection
    private func brandsSection() -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text(Resources.Text.brands)
                .airbnbCerealFont(.medium, size: 20)
                .foregroundStyle(.secondary).opacity(0.6)
            
            LazyVGrid(
                columns: columns,
                spacing: 16
            ) {
                
                ForEach(brands) { brand in
                    
                    BrandCard(brand: brand)
                }
            }
        }
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
    
    NavigationStack {
        InventoryScreen()
    }
    .modelContainer(container)
    .environment(\.appContainer, appContainer)
}
