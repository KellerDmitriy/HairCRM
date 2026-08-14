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
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                AppTextField(
                    title:Resources.Text.nameCategory,
                    text: $name
                )
                
                
                AppAddNewButton(title: Resources.Text.addNew, value: nil) {
                    if
                        viewModel.addCategory(
                            name: name
                        ) {
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    AppCloseButton {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    ToolBarTitleView(title: Resources.Text.addNewCategory.localized)
                }
            }
            .padding()
        }
    }
}
