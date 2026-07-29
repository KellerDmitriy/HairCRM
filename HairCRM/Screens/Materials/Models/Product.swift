//
//  ExploreModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import Foundation

struct Product: Identifiable {
    let id: UUID
    let category: ProductCategory
    // Бренд
    // Например: Goldwell
    let brand: Brand?
    // Линейка продукта
    // Например: Topchic
    let series: String?
    // Название товара
    // Например: 7NA
    let name: String
    // Остаток
    let quantity: Double
    // Единица измерения
    let unit: ProductUnit
    // Дата поступления
    let dateOfPurchase: Date?
    // Фото товара
    let imageData: Data?
}

struct ProductCategory: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
}

struct Brand: Identifiable {
    let id: UUID
    let name: String
    let image: Data?
}

// MARK: - Unit (единицы измерения)
enum ProductUnit: String, Codable {
    case piece = "шт"
    case gram = "г"
    case milliliter = "мл"
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
