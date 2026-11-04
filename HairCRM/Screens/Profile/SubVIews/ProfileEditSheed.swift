//
//  ProfileEditSheed.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 02.11.2026.
//

import SwiftUI
import PhotosUI

struct ProfileEditSheed: View {
    @Environment(\.dismiss)
    private var dismiss
    
    let mode: ProfileMode
    
    @Binding var name: String
    @Binding var imageData: Data?
    
    let onSave: () -> Void
    
    @State private var selectedImage: PhotosPickerItem?
    
    // MARK: - Body
    var body: some View {
        AppFormCard {
            VStack(spacing: 20) {
                Text(
                    mode.isEdit
                    ? Resources.Text.editProfile
                    : Resources.Text.createProfile
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
                                width: 100,
                                height: 100
                            )
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(.gray.opacity(0.3))
                            .frame(
                                width: 100,
                                height: 100
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
                
                AppButton(title: Resources.Text.save) {
                    onSave()
                }
            }
        }
        .padding()
        .background(Color.appBackground)
    }
}

#Preview {
    @Previewable @State var name = "Keller Style"
    @Previewable @State var imageData: Data? = nil

    ProfileEditSheed(
        mode: .create,
        name: $name,
        imageData: $imageData,
        onSave: {}
    )
}
