//
//  BrandFormView.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//

import SwiftUI
import PhotosUI

struct BrandFormView: View {
    @Environment(\.dismiss)
    private var dismiss
    
    let mode: BrandMode
    
    @Binding var name: String
    @Binding var imageData: Data?
    
    let onSave: () -> Void
    
    @State private var selectedImage: PhotosPickerItem?
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text(
                mode.isEdit
                ? Resources.Text.edit
                : Resources.Text.addNewBrand
            )
            .airbnbCerealFont(.medium, size: 20)
            .foregroundStyle(.secondary).opacity(0.6)
            
            PhotosPicker(
                selection: $selectedImage,
                matching: .images
            ) {
                
                if let imageData,
                   let image = UIImage(data: imageData) {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: 80,
                            height: 80
                        )
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(
                            width: 80,
                            height: 80
                        )
                }
            }
            .onChange(of: selectedImage) { _, item in
                Task {
                    guard let data = try? await item?.loadTransferable(type: Data.self)
                    else { return }
                    imageData = ImageProcessor.resize(imageData: data)
                }
            }
            
            AppTextField(
                title:Resources.Text.name,
                text: $name
            )
            HStack {
                Button {
                    onSave()
                } label: {
                    Text(
                        mode.isEdit
                        ? Resources.Text.save
                        : Resources.Text.addNew
                    )
                }
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text(Resources.Text.cancel)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
