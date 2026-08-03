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
        sort: \Product.name
        )
    private var products: [Product]
    
    @Query(
        sort: \ProductCategory.name
        )
    private var productCategory: [ProductCategory]
    
    @State private var showSuggestions = true
    @State private var showSearchFlow = false
    
    // MARK: - Init
    init(viewModel: InventoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            materialCategoriesCell()
                .padding(.bottom, 5)
            Spacer()
        }
        .padding(.top)
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolBarButton(icon: .plus) { showSearchFlow = true }
            }
            
            ToolbarItem(placement: .principal) {
                ToolBarTitleView(title: Resources.Text.materials.localized)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarButton(icon: .searchWhite) { showSearchFlow = true }
            }
        }
    }
    
    private func materialCategoriesCell() -> some View {
        return List {
            ForEach(productCategory) { category in
                NavigationLink {
                    ProductCategoryScreen(
                        category: category
                    )
                } label: {
                    Text(category.name)
                }
                .listRowBackground(Color.clear)
            }
//            .onDelete(perform: viewModel.deleteCategory(at:))
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .background(Color.clear)
        .frame(height: 400)
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
