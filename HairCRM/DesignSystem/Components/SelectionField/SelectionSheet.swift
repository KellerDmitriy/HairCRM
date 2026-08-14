//
//  SelectionSheet.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 06.08.2026.
//


import SwiftUI

struct SelectionSheet<Item: Identifiable>: View {

    @Environment(\.dismiss)
    private var dismiss

    let title: String

    let items: [Item]

    @Binding
    var selectedItem: Item?

    let displayName: (Item) -> String

    let onCreate: (String) -> Void

    @State private var searchText = ""
    @State private var newItemName = ""

    @State private var isCreating = false

    private var filteredItems: [Item] {

        if searchText.isEmpty {
            return items
        }

        return items.filter {
            displayName($0)
                .localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                if isCreating {
                    createView
                  
                } else {
                    listView
                       
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - ListView
extension SelectionSheet {

    private var listView: some View {
        VStack {
            CustomSearchBarView(
                isSearchPresented: .constant(false),
                searchText: $searchText,
                scope: .brands
            )
            
            List {
                ForEach(filteredItems) { item in
                    Button {
                        selectedItem = item
                        dismiss()

                    } label: {
                        HStack {
                            Text(displayName(item))
                            Spacer()
                            if selectedItem?.id == item.id {

                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                Section {
                    Button {
                        withAnimation {
                            isCreating = true
                        }
                    } label: {
                        Label(
                            "Добавить новый",
                            systemImage: "plus"
                        )
                    }
                }
            }
        }
    }
}

// MARK: - CreateView
extension SelectionSheet {

    private var createView: some View {
        VStack(spacing: 20) {
            TextField(
                Resources.Text.name,
                text: $newItemName
            )
            .textFieldStyle(.roundedBorder)
            .airbnbCerealFont(AirbnbCerealFont.medium, size: 20)
            
            Button {
                let value = newItemName
                    .trimmingCharacters(
                        in: .whitespaces
                    )
                guard !value.isEmpty else {
                    return
                }
                onCreate(value)

                dismiss()

            } label: {
                Text(Resources.Text.addNew)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button {
                isCreating = false
                newItemName = ""
            } label: {
                Text(Resources.Text.cancel)
            }
        }
        .padding()
    }
}

