//
//  ProfileViewModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 02.11.2026.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var currentUserInfo: ProfileInfo? = nil
    @Published var error: Error? = nil
    
    
}
