//
//  ProductCategoryScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import SwiftUI

struct ProductCategoryScreen: View {
    @ObservedObject
    var viewModel: InventoryViewModel
    
    let category: ProductCategory
 
    @State private var showAddProductView = false
    @State private var showSuggestions = false
    @State private var searchText = ""
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                
                if category.products.isEmpty {
                    noProductsContent
                    
                } else {
                    productsView
                }
                Spacer()
                searchView()
                    .padding(.bottom,90)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(.appBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolBarTitleView(title: category.name.capitalized)
            }
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarButton(icon: .plus) {
                    showAddProductView = true
                }
            }
        }
        .sheet(isPresented: $showAddProductView) {
            AddProductSheet(viewModel: viewModel, category: category)
        }
    }
    
    // MARK: - Search Views
    private func searchView() -> some View {
          return CustomSearchBarView(
              isSearchPresented: $showSuggestions,
              searchText: $searchText,
              scope: .products,
              shouldHandleTextInput: true,
              filterAction: {_ in }
          )
          .zIndex(1)
      }
    
    // MARK: - Content Views
    private var productsView: some View {
        List(category.products) { product in

            ProductCell(product: product)
                .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .background(Color.clear)
    }
    
    private var noProductsContent: some View {
        Text(Resources.Text.notFound.uppercased())
            .airbnbCerealFont(AirbnbCerealFont.bold, size: 26)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

import SwiftData
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
    
    NavigationView{
        ProductCategoryScreen(
            viewModel: InventoryViewModel(inventoryService: appContainer.inventoryService), category: ProductCategory(
                name: "Краситель")
        )
    }
}
