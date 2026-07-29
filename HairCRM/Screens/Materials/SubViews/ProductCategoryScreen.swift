//
//  ProductCategoryScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import SwiftUI

struct ProductCategoryScreen: View {
    
    let category: ProductCategory
    @ObservedObject var viewModel: MaterialsViewModel
    @State private var showAddProductView = false
    @State private var showSuggestions = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                
                if viewModel.products.isEmpty {
                    noProductsContent
                    
                } else {
                    productsView
                }
                Spacer()
                searchView()
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
    }
    
    // MARK: - Search Views
    private func searchView() -> some View {
          return CustomSearchBarView(
              isSearchPresented: $showSuggestions,
              searchText: $viewModel.searchText,
              shouldHandleTextInput: true,
              fiterAction: {_ in }
          )
          .zIndex(1)
      }
    
    // MARK: - Content Views
    private var productsView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(viewModel.products) { product in
                    ProductCell(product: product)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 5)
                   
                }
            }
        }
    }
    
    private var noProductsContent: some View {
        Text(Resources.Text.notFound.uppercased())
            .airbnbCerealFont(AirbnbCerealFont.bold, size: 26)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationView{
        ProductCategoryScreen(
            category: ProductCategory(
                id: UUID(),
                name: "Краситель"),
            viewModel: MaterialsViewModel())
    }
}
