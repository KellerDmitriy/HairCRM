//
//  CategoryMode.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//

import Foundation

enum CategoryMode: Identifiable {
    case create
    case edit(ProductCategory)

    var id: String {
        switch self {
        case .create:
            return "create"

        case .edit(let category):
            return category.id.uuidString
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
