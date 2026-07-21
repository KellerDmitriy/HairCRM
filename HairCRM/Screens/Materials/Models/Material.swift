//
//  ExploreModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import Foundation

struct Material: Identifiable {
    let id: Int
    let category: MaterialCategory
    let brand: String
    let title: String
    let balance: Double
    let dateOfPurchase: Date?
    let image: String?
}

struct MaterialCategory: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
}

//enum MaterialCategory: String, CaseIterable, Codable {
//    case hairColor
//    case developer
//    case lightener
//    case hairCare
//    case consumables
//    case tools
//    case miscellaneous
//    
//    var title: String {
//        switch self {
//        case .hairColor: "Hair Color"
//        case .developer: "Developer"
//        case .lightener: "Lightener"
//        case .hairCare: "Hair Care"
//        case .consumables: "Consumables"
//        case .tools: "Tools"
//        case .miscellaneous: "Miscellaneous"
//        }
//    }
//    
//    var systemImage: String {
//        switch self {
//        case .hairColor: "paintpalette.fill"
//        case .developer: "drop.fill"
//        case .lightener: "sparkles"
//        case .hairCare: "heart.text.square.fill"
//        case .consumables: "shippingbox.fill"
//        case .tools: "scissors"
//        case .miscellaneous: "square.grid.2x2.fill"
//        }
//    }
//}
