//
//  MaterialsScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI

struct MaterialsScreen: View {
    @StateObject private var viewModel: MaterialsViewModel
    
    @State private var showSuggestions = true
    @State private var showSearchFlow = false
    
    // MARK: - Init
    init() {
        self._viewModel = StateObject(wrappedValue: MaterialsViewModel())
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            materialCategoriesCell()
                .padding(.bottom, 5)
            Spacer()
        }
        .padding(.top, 70)
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
            ForEach(viewModel.categories) { category in
                NavigationLink {
                    ProductCategoryScreen(
                        category: category,
                        viewModel: viewModel
                    )
                } label: {
                    Text(category.name)
                }
                .listRowBackground(Color.clear)
            }
            .onDelete(perform: viewModel.deleteCategory(at:))
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .background(Color.clear)
        .frame(height: 400)
    }
}

#Preview {
    NavigationView {
        MaterialsScreen()
    }
}
