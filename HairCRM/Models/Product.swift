//
//  ExploreModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import Foundation
import SwiftData

@Model
final class ProductGroup {

    var id: UUID

    // Основной раздел
    // Красители
    // Уход
    // Расходники
    var name: String


    @Relationship(
        deleteRule: .deny,
        inverse: \ProductCategory.group
    )
    var categories: [ProductCategory]


    init(
        name: String
    ) {
        self.id = UUID()
        self.name = name
        self.categories = []
    }
}

@Model
final class Product {
    // Уникальный идентификатор товара
    var id: UUID

    // Категория товара
    var category: ProductCategory?

    // Бренд
    // Например: Goldwell
    var brand: Brand?

    // Линейка продукта
    // Например: Topchic
    var series: String?

    // Название товара
    // Например: 7NA
    var name: String

    // Текущий остаток
    var quantity: Double

    // Единица измерения
    var unit: ProductUnit
    
    // Минимальный остаток
    var minimumQuantity: Double

    // Количество использований
    var usageCount: Int
    
    // Последнее использование
    var lastUsedAt: Date?
    
    // Дата поступления
    var dateOfPurchase: Date?

    // Фото товара
    var imageData: Data?

    init(
        category: ProductCategory? = nil,
        brand: Brand? = nil,
        series: String? = nil,
        name: String,
        quantity: Double = 0,
        unit: ProductUnit,
        minimumQuantity: Double,
        usageCount: Int = 0,
        lastUsedAt: Date? = nil,
        dateOfPurchase: Date? = nil,
        imageData: Data? = nil
    ) {
        self.id = UUID()
        self.category = category
        self.brand = brand
        self.series = series
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.minimumQuantity = minimumQuantity
        self.usageCount = usageCount
        self.lastUsedAt = lastUsedAt
        self.dateOfPurchase = dateOfPurchase
        self.imageData = imageData
    }
}

// MARK: - ProductCategory
@Model
final class ProductCategory {

    var id: UUID

    // Например:
    // Перманентные красители
    // Тонирующие красители
    // Маски
    // Перчатки
    var name: String


    var group: ProductGroup?

    @Relationship(
        deleteRule: .deny,
        inverse: \Product.category
    )
    var products: [Product]


    init(
        name: String,
        group: ProductGroup? = nil
    ) {

        self.id = UUID()
        self.name = name
        self.group = group
        self.products = []
    }
}

// MARK: - Brand
@Model
final class Brand {
    // Уникальный идентификатор бренда
    var id: UUID

    // Название бренда
    // Например: Goldwell
    var name: String

    // Логотип / изображение бренда
    var imageData: Data?

    // Товары данного бренда
    @Relationship(deleteRule: .deny,
                  inverse:  \Product.brand
    )
    var products: [Product]

    init(
        name: String,
        imageData: Data? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.imageData = imageData
        self.products = []
    }
}

// MARK: - Unit (единицы измерения)
enum ProductUnit: String, Codable {
    case piece = "шт"
    case gram = "г"
    case milliliter = "мл"
}


