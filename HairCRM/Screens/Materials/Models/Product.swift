//
//  ExploreModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import Foundation
import SwiftData



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

    // Дата поступления
    var dateOfPurchase: Date?

    // Фото товара
    var imageData: Data?

    init(
        id: UUID = UUID(),
        category: ProductCategory? = nil,
        brand: Brand? = nil,
        series: String? = nil,
        name: String,
        quantity: Double = 0,
        unit: ProductUnit,
        dateOfPurchase: Date? = nil,
        imageData: Data? = nil
    ) {
        self.id = id
        self.category = category
        self.brand = brand
        self.series = series
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.dateOfPurchase = dateOfPurchase
        self.imageData = imageData
    }
}

// MARK: - ProductCategory
@Model
final class ProductCategory {
    // Уникальный идентификатор категории
    var id: UUID

    // Название категории
    // Например:
    // Красители, Окислители, Уход
    var name: String

    // Товары данной категории
    @Relationship(deleteRule: .nullify)
    var products: [Product]

    init(
        id: UUID = UUID(),
        name: String
    ) {
        self.id = id
        self.name = name
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
    @Relationship(deleteRule: .nullify)
    var products: [Product]

    init(
        id: UUID = UUID(),
        name: String,
        imageData: Data? = nil
    ) {
        self.id = id
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


