//
//  AddBrandSheed.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//


import SwiftUI

struct AddBrandSheed: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @ObservedObject
    var viewModel: InventoryViewModel
    
    let brands: [Brand]
    
    @State private var mode: BrandMode?
    
    @State private var searchText = ""
    @State private var newItemName = ""
    @State private var imageData: Data?
    
    private var filteredItems: [Brand] {
        if searchText.isEmpty {
            return brands
        }
        
        return brands.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                listView()
                    .background(.appBackground)
            }
            .background(.appBackground)
            .navigationTitle(Resources.Text.brands)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .background(.appBackground)
        .alert(item: $viewModel.appError) { error in
            Alert(
                title: Text(Resources.Text.error),
                message:  Text(error.localizedDescription),
                dismissButton: .default(Text(Resources.Text.ok))
            )
        }
        .sheet(item: $mode) { mode in
            BrandFormView(
                mode: mode,
                name: $newItemName,
                imageData: $imageData,
                onSave: save
            )
            .presentationDetents([.medium])
        }
    }
    
    // MARK: - Save
    private func save() {
        
        guard let mode else {
            return
        }
        
        switch mode {
        case .create:
            viewModel.addBrand(name: newItemName, imageData: imageData)
        case .edit(let brand):
            viewModel.updateBrand(brand, name: newItemName, imageData: imageData)
        }
    }
}

// MARK: - ListView
extension AddBrandSheed {
    
    private func listView() -> some View {
        VStack {
            CustomSearchBarView(
                isSearchPresented: .constant(false),
                searchText: $searchText,
                scope: .brands
            )
            .padding()
            
            List {
                ForEach(filteredItems) { brand in
                    
                    HStack(spacing: 12) {
                        // MARK: - Brand Image
                        if let imageData = brand.imageData,
                           let uiImage = UIImage(data: imageData) {
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(.secondary.opacity(0.15))
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Image(systemName: "building.2")
                                        .foregroundStyle(.secondary)
                                }
                        }
                        
                        // MARK: - Brand Name
                        Text(brand.name)
                            .airbnbCerealFont(
                                AirbnbCerealFont.medium,
                                size: 16
                            )
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                    
                    // MARK: - Swipe Actions
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        // Edit
                        Button {
                            newItemName = brand.name
                            imageData = brand.imageData
                            mode = .edit(brand)
                        } label: {
                            Label(
                                Resources.Text.edit,
                                systemImage: "pencil"
                            )
                        }
                        .tint(.blue)
                        
                        // Delete
                        Button(role: .destructive) {
                            viewModel.deleteBrand(brand)
                        } label: {
                            Label(
                                Resources.Text.delete,
                                systemImage: "trash"
                            )
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(.appBackground)
                // MARK: - Add Brand
            Section {
                Button {
                    newItemName = ""
                    imageData = nil
                    mode = .create
                } label: {
                    Label(
                        Resources.Text.addNewBrand,
                        systemImage: "plus"
                    )
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.bottom, 16)
        }
        .background(.appBackground)
    }
}


