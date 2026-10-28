//
//  AddCategorySheet.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//

import SwiftUI

struct AddCategorySheet: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @ObservedObject
    var viewModel: InventoryViewModel
    
    @State private var name = ""
    @State private var showError = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            AppFormCard {
                VStack(spacing: 24) {
                    AppTextField(
                        title:Resources.Text.nameCategory,
                        text: $name
                    )
                    
                    AppAddNewButton(
                        title: Resources.Text.addNew,
                        value: nil
                    ) {
                        addCategory()
                    }
                }
            }
            .padding(.top, 4)
            .padding()
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    AppCloseButton { dismiss() }
                }
                
                ToolbarItem(placement: .principal) {
                    ToolBarTitleView(title: Resources.Text.addNewCategory.localized)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    AppAddButton { addCategory() }
                    .disabled(name.isEmpty)
                }
            }
            .alert(Resources.Text.error, isPresented: $showError) {
                Button(Resources.Text.ok) {
                    viewModel.appError = nil
                }
            } message: {
                Text(viewModel.appError?.localizedDescription ?? "")
            }
        }
    }
    
//MARK:- helpers methods
    private func addCategory() {
        viewModel.appError = nil
        
        if
            viewModel.addCategory(
                name: name
            ) {
            dismiss()
        } else {
            showError = viewModel.appError != nil
        }
    }
}

