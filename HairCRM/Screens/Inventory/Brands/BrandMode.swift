//
//  BrandMode.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//

import SwiftUI

enum BrandMode: Identifiable {
    case create
    case edit(Brand)

    var id: String {
        switch self {
        case .create:
            return "create"

        case .edit(let brand):
            return "edit-\(brand.persistentModelID)"
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
