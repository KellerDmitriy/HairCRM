//
//  InventoryService.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 03.08.2026.
//


import SwiftData

@MainActor
final class InventoryService: InventoryServiceProtocol {

    // MARK: - Properties

    private let service: SwiftDataService

    // MARK: - Init

    init(service: SwiftDataService) {
        self.service = service
    }

    // MARK: - Product

    func createProduct(_ product: Product) throws {
        try service.insert(product)
    }

    func deleteProduct(_ product: Product) throws {
        try service.delete(product)
    }

    // MARK: - Category

    func createCategory(_ category: ProductCategory) throws {
        try service.insert(category)
    }

    func deleteCategory(_ category: ProductCategory) throws {
        try service.delete(category)
    }

    // MARK: - Brand

    func createBrand(_ brand: Brand) throws {
        try service.insert(brand)
    }

    func deleteBrand(_ brand: Brand) throws {
        try service.delete(brand)
    }
    
    // MARK: - Persistence

    func save() throws {
        try service.save()
    }
}
