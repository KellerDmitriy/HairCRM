//
//  ClientMode.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 14.08.2026.
//


import SwiftUI

enum ClientMode: Identifiable {
    case create
    case edit(ClientModel)

    var id: String {
        switch self {
        case .create:
            return "create"

        case .edit(let client):
            return "edit-\(client.persistentModelID)"
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
