//
//  SearchScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 29.07.2026.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel: SearchViewModel
    
    @State private var showSuggestion = true
    
    // MARK: - Init
    init(viewModel: SearchViewModel) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel()
        )
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            CustomSearchBarView(
                isSearchPresented: $showSuggestion,
                searchText: $viewModel.searchText,
                shouldHandleTextInput: true,
                fiterAction: {_ in }
            )
            .padding(.horizontal)
            .padding(.top)
            .zIndex(1)
            
            Spacer()
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Content Views
    
    
}

#Preview {
    SearchScreen(viewModel: SearchViewModel())
}
