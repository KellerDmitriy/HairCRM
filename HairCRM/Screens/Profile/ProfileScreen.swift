//
//  ProfileScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI
import SwiftData

struct ProfileScreen: View {
    @Environment(\.modelContext)
    
    private var modelContext
    
    @Query
    private var profiles: [ProfileInfo]
    
    private var profile: ProfileInfo? {
        profiles.first
    }
    
    @State private var mode: ProfileMode?
    @State private var name = ""
    @State private var imageData: Data?
    
    var body: some View {
        NavigationStack {
            VStack {
                ProfileCard(
                    name: profile?.name ?? "введите имя",
                    avatar: profile?.avatarImage,
                    onEdit: { editProfile() }
                )
                ScrollView {

                }
            }
            .padding()
            .background(Color.appBackground).ignoresSafeArea()
            .padding(.top)
            .background(.appBackground)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            
            .sheet(item: $mode) { currentMode in
                ProfileEditSheed(
                    mode: currentMode,
                    name: $name,
                    imageData: $imageData,
                    onSave: { saveProfile(currentMode) }
                )
            }
        }
    }
    
    private func editProfile() {
        guard let profile else {
            name = ""
            imageData = nil
            mode = .create
            return
        }

        name = profile.name
        imageData = profile.avatarImage
        mode = .edit(profile)
    }
    
    private func saveProfile(_ currentMode: ProfileMode) {

           let cleanedName = name.trimmingCharacters(
               in: .whitespacesAndNewlines
           )

           guard !cleanedName.isEmpty else { return }

           switch currentMode {

           case .create:

               let profile = ProfileInfo(
                   name: cleanedName,
                   avatarImage: imageData
               )

               modelContext.insert(profile)

           case .edit(let profile):

               profile.name = cleanedName
               profile.avatarImage = imageData
           }

           do {
               try modelContext.save()
               mode = nil

           } catch {
               print("Ошибка сохранения профиля: \(error)")
           }
       }
    
}

#Preview {
    ProfileScreen()
}
