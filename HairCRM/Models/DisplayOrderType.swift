//
//  DisplayOrderType.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//


enum DisplayOrderType: CaseIterable {
    case alphabetical
    case brand
    case name

    var name: String {
        switch self {
        case .alphabetical:
            return "alphabetical".localized
        case .brand:
            return "by brand".localized
        case .name:
            return "by name".localized
        }
    }
}
