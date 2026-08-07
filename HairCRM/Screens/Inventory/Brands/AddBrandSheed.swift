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

    let brands: [Brand]

    let onCreate: (String, Data?) -> Void
    let onUpdate: (Brand, String, Data?) -> Void
    let onDelete: (Brand) -> Void

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

                if let mode {
                    BrandFormView(
                        mode: mode,
                        name: $newItemName,
                        imageData: $imageData,
                        onSave: save
                    )
                } else {
                    listView()
                }
            }
            .navigationTitle(Resources.Text.brands)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Save
    private func save() {
        if let mode {
            switch mode {
            case .create:
                onCreate(newItemName, imageData)
                
            case .edit(let brand):
                onUpdate(brand, newItemName, imageData)
            
            }
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
            .padding(.horizontal)

            List {

                ForEach(filteredItems) { brand in

                    Button {
                        newItemName = brand.name
                        imageData = brand.imageData
                        mode = .edit(brand)

                    } label: {

                        HStack {

                            Text(brand.name)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing) {

                        Button(role: .destructive) {

                            onDelete(brand)

                        } label: {

                            Label(
                                Resources.Text.delete,
                                systemImage: "trash"
                            )
                        }
                    }
                }

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
                    }
                }
            }
        }
    }
}


