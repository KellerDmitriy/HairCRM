//
//  ProfileCard.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 02.11.2026.
//

import SwiftUI

struct ProfileCard: View {
    let name: String
    let avatar: Data?
    let onEdit: () -> Void
    
    var body: some View {
        AppFormCard {
            ZStack {
                VStack(alignment: .center) {
                    avatarView
                    Text(name.isEmpty ? Resources.Text.userName : name)
                        .airbnbCerealFont(.medium, size: 18)
                        .foregroundStyle(.appForegroundStyle)
                    AppButton(
                        title: Resources.Text.editProfile) {
                            onEdit()
                        }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private var avatarView: some View {
        if let avatar, let uiImage = UIImage(data: avatar) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
            
        } else {
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundStyle(.secondary.opacity(0.4))
        }
        
    }
}


#Preview {
    ProfileCard(name: "KellerStyle", avatar: nil, onEdit: {})
}
