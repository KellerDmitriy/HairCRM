//
//  InventoryViewModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//

import Foundation

@MainActor
final class InventoryViewModel: ObservableObject {
    
    private let inventoryService: InventoryServiceProtocol
    
    @Published var searchResults: [Product] = []
    
    @Published var searchText: String = "" {
        didSet {
            debounceSearchTask()
        }
    }
    
    @Published var recentSearches: [String] = []
    
    
    // MARK: - Init
    init(inventoryService: InventoryServiceProtocol) {
        self.inventoryService = inventoryService
    }
    
    
    // MARK: - Вebounce Search Task
    private func debounceSearchTask() {
        
    }
    
    // MARK: Product
    func addProduct(_ product: Product) { try? inventoryService.createProduct(product) }
    
    func deleteProduct(_ product: Product) { try? inventoryService.deleteProduct(product) }
    
    // MARK: Categories
    func addCategory(name: String) {
        let category = ProductCategory(name: name)
        try? inventoryService.createCategory(category)
    }
    
    func deleteCategory(_ category: ProductCategory) { try? inventoryService.deleteCategory(category) }
    
    // MARK: Brand
    func addBrand(name: String) {
        
        let brand = Brand(
            name: name
        )
        
        try? inventoryService.createBrand(brand)
    }
    
    func deleteBrand(_ brand: Brand) { try? inventoryService.deleteBrand(brand) }
    
}
