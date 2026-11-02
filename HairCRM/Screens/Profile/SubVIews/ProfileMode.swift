//
//  ProfileMode.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 02.11.2026.
//

import Foundation

enum ProfileMode: Identifiable {
case create
case edit(ProfileInfo)

var id: String {
    switch self {
    case .create:
        return "create"

    case .edit(let profileInfo):
        return "edit-\(profileInfo.persistentModelID)"
    }
}

var isEdit: Bool {
    switch self {
    case .create:
        return false
    case .edit:
        return true
    }
}
}
