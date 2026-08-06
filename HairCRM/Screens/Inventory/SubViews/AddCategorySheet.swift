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
        
        VStack(spacing: 24) {
            
            Text(Resources.Text.addNewCategory)
                .airbnbCerealFont(AirbnbCerealFont.book, size: 18)
            
            TextField(
                Resources.Text.nameCategory,
                text: $name
            )
            .textFieldStyle(.roundedBorder)
            
            
            Button {
                viewModel.addCategory(
                    name: name
                )
                dismiss()
                
            } label: {
                Text(Resources.Text.addNew)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        .presentationDetents(
            [.height(250)]
        )
    }
}
