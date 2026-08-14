//
//  AddClientSheet.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//

import SwiftUI

struct AddClientSheet: View {
    @Environment(\.dismiss)
    private var dismiss
    
    @ObservedObject
    var viewModel: ClientViewModel
    
    let mode: ClientMode
    @State private var name = ""
    @State private var surname = ""
    @State private var phone = ""
    @State private var note = ""
    
    @FocusState
    private var focusedField: Field?

    private enum Field: Hashable {
        case name
        case surname
        case phone
        case note
    }
        
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                clientData()
                    .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .background(.appBackground)
            .contentShape(Rectangle())
            .onTapGesture {
                focusedField = nil
            }
            .navigationTitle(
                mode.isEdit
                ? Resources.Text.editClient
                : Resources.Text.addNewClient
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AppCloseButton {
                        dismiss()
                    }
                }
            }
        }
        .background(.appBackground)
    }
    
    // MARK: - helpers
    private func save() {
        let client = ClientModel(
            name: name,
            surname: surname,
            phone: phone,
            notes: note
        )
        viewModel.addNewClient(client)
    }
    
    // MARK: - clientSection
    private func clientData() -> some View {
        AppFormCard {
            VStack(spacing: 12) {

                AppTextField(
                    title: Resources.Text.clientName,
                    text: $name,
                    textContentType: .givenName,
                    autocapitalization: .words
                )
                .focused($focusedField, equals: .name)

                AppTextField(
                    title: Resources.Text.clientSurname,
                    text: $surname,
                    textContentType: .familyName,
                    autocapitalization: .words
                )
                .focused($focusedField, equals: .surname)

                AppTextField(
                    title: Resources.Text.clientPhone,
                    text: $phone,
                    keyboardType: .phonePad,
                    textContentType: .telephoneNumber,
                    autocapitalization: .never,
                    autocorrectionDisabled: true
                )
                .focused($focusedField, equals: .phone)

                AppTextField(
                    title: Resources.Text.clientNote,
                    text: $note,
                    axis: .vertical
                )
                .focused($focusedField, equals: .note)
            }
        }
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
    
    NavigationStack {
        AddClientSheet(
            viewModel: ClientViewModel(clientService: appContainer.clientService), mode: .create)
    }
    .modelContainer(container)
    .environment(\.appContainer, appContainer)
    
    
}
