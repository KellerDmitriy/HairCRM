//
//  MaterialCategoryView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import SwiftUI

struct MaterialCategoryView: View {
    let category: MaterialCategory
    @ObservedObject var viewModel: MaterialsViewModel
    @State private var showSuggestions = true
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack{
                CustomSearchBarView(
                    isSearchPresented: $showSuggestions,
                    searchText: $viewModel.searchText,
                    shouldHandleTextInput: true,
                    fiterAction: {_ in }
                )
                .zIndex(1)
                
                HStack(alignment: .center) {
                    Text(category.name.capitalized)
                        .airbnbCerealFont(.bold, size: 20)
                        .foregroundStyle(.appForegroundStyle)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    
    }
}

#Preview {
    MaterialCategoryView(
        category: MaterialCategory(
            id: UUID(),
            name: "Краситель"),
        viewModel: MaterialsViewModel())
}
