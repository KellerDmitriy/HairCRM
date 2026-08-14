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
            .task {
                let seeder = DatabaseSeeder(
                    inventoryService: container.inventoryService
                )
                seeder.seedIfNeeded()
            }
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
    
    @State private var categoryMode: CategoryMode?
    @State private var categoryName = ""

    @State private var isCategoriesExpanded = true
    @State private var isBrandsExpanded = true
    
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
                
                brandsSection()
        }
        .padding(20)
        .padding(.top)
        .padding(.bottom, 60)
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolBarButton(icon: .plus) {  showAddCategory = true }
            }
            
            ToolbarItem(placement: .principal) {
                ToolBarTitleView(title: Resources.Text.store.localized)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarButton(icon: .searchWhite) { showSearchFlow = true }
            }
        }
        .alert(item: $viewModel.appError) { error in
            Alert(
                title: Text(Resources.Text.error),
                message:  Text(error.localizedDescription),
                dismissButton: .default(Text(Resources.Text.ok))
            )
        }
        
        .sheet(isPresented: $showAddCategory) {
            AddCategorySheet(viewModel: viewModel)
                .presentationDetents([.medium])
        }
        
        .sheet(isPresented: $showBrandSelection) {
            AddBrandSheed(
                viewModel: viewModel,
                brands: brands
            )
        }
    }
    
    // MARK: - Categories Section
    private func categoriesSection() -> some View {
        AppFormCard {
            VStack(alignment: .leading, spacing: 8) {
                
                // MARK: - Header
                AppSectionHeader(
                    title: Resources.Text.categories,
                    isExpanded: $isCategoriesExpanded
                )
                
                // MARK: - Categories
                if isCategoriesExpanded {
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
                            .background(.pink.opacity(0.5))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 16)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .animation(
                .easeInOut(duration: 0.2),
                value: isCategoriesExpanded
            )
        }
    }
    
    // MARK: - Add BrandSection
    private func addBrandSection() -> some View {
        AppAddNewButton(
                title: Resources.Text.addNewBrand,
                value: nil
            ) {
                showBrandSelection = true
            }
    }
    
    // MARK: - BrandsSection
    private func brandsSection() -> some View {
        AppFormCard {
            
            VStack(alignment: .leading, spacing: 8) {
                AppSectionHeader(
                    title: Resources.Text.brands,
                    isExpanded: $isBrandsExpanded
                )
                
                if isBrandsExpanded {
                    LazyVGrid(
                        columns: columns,
                        spacing: 16
                    ) {
                        
                        ForEach(brands) { brand in
                            BrandCard(brand: brand)
                        }
                    }
                    .animation(
                        .easeInOut(duration: 0.2),
                        value: isBrandsExpanded
                    )
                }
              addBrandSection()
                
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
