//
//  CustomSearchBarView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//


import SwiftUI

struct CustomSearchBarView: View {
    @Binding var isSearchPresented: Bool
    @Binding var searchText: String
    
    let scope: SearchScope
    
    let textColor: Color
    let magnifierColor: Color
    let placeholderColor: Color
    
    let shouldHandleTextInput: Bool
    private let filterAction: ((DisplayOrderType) -> Void)?
    var isFiltering = false
    
//    MARK: - INIT
    init(
        isSearchPresented: Binding<Bool>,
        searchText: Binding<String>,
        scope: SearchScope,
        shouldHandleTextInput: Bool = true,
        filterAction: ((DisplayOrderType) -> Void)? = nil,
        isFiltering: Bool = false,
        textColor: Color = .appForegroundStyle,
        magnifierColor: Color = .white,
        placeholderColor: Color = .searchBarPlaceholder
    ) {
        self._isSearchPresented = isSearchPresented
        self._searchText = searchText
        self.scope = scope
        
        self.shouldHandleTextInput = shouldHandleTextInput
        self.filterAction = filterAction
        self.isFiltering = isFiltering
        
        self.textColor = textColor
        self.magnifierColor = magnifierColor
        self.placeholderColor = placeholderColor
    }
    
    
    // MARK: - Body
      var body: some View {
          HStack(spacing: 10) {
              Button {
                  isSearchPresented.toggle()
              } label: {
                  Image(.searchWhite)
                      .resizable()
                      .frame(
                          width: 24,
                          height: 24
                      )
              }
              
              Rectangle()
                  .frame(
                      width: 1,
                      height: 20
                  )
                  .foregroundStyle(
                      placeholderColor
                  )
              
              searchField
              
              if isFiltering,
                 let filterAction {
                  
                  FiltersButton(
                      filterAction: filterAction
                  )
              }
          }
      }
  }

// MARK: - Extension placeholderText
extension CustomSearchBarView {
    
    private var placeholderText: String {
        
        switch scope {
        case .products:
            return Resources.Text.searchProduct
        case .clients:
            return Resources.Text.searchClient
        case .services:
            return Resources.Text.searchService
        case .categories:
            return Resources.Text.searchCategory
        case .brands:
            return Resources.Text.searchBrand
        }
    }
}
// MARK: - Extension SearchField
extension CustomSearchBarView {
    
    @ViewBuilder
    private var searchField: some View {
        
        if shouldHandleTextInput {
            
            TextField("", text: $searchText)
            .airbnbCerealFont(
                AirbnbCerealFont.book,
                size: 18
            )
            .foregroundStyle(textColor)
            .placeholder(
                when: searchText.isEmpty
            ) {
                Text(placeholderText)
                    .foregroundStyle(
                        placeholderColor
                    )
            }
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(
                        systemName: "xmark.circle.fill"
                    )
                    .foregroundStyle(
                        textColor
                    )
                }
            }
            
        } else {
            
            Text(placeholderText)
                .foregroundStyle(
                    placeholderColor
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .onTapGesture {
                    isSearchPresented = true
                }
        }
    }
}

#Preview {
    CustomSearchBarView(isSearchPresented: .constant(true), searchText: .constant("true"), scope: .products)
}
