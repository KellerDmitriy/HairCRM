//
//  BrandMode.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//

import SwiftUI

enum BrandMode {
    case create
    case edit(Brand)
}

extension BrandMode {
    var isEdit: Bool {
        switch self {
        case .edit:
            return true
        case .create:
            return false
        }
    }
}
