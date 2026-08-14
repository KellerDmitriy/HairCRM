//
//  InventoryServiceProtocol.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 29.07.2026.
//


import Foundation

@MainActor
protocol InventoryServiceProtocol {

    // MARK: - Product

    func createProduct(_ product: Product) throws
    func deleteProduct(_ product: Product) throws

    // MARK: - Category

    func createCategory(_ category: ProductCategory) throws
    func deleteCategory(_ category: ProductCategory) throws

    // MARK: - Brand

    func createBrand(_ brand: Brand) throws
    func deleteBrand(_ brand: Brand) throws
    
    // MARK: - Persistence
    func save() throws
}
