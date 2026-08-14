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
    
    @Published var appError: InventoryError?
    
    
    // MARK: - Init
    init(inventoryService: InventoryServiceProtocol) {
        self.inventoryService = inventoryService
    }
    
    // MARK: - Handle Error
    private func handleError(_ error: Error) {
        if let inventoryError = error as? InventoryError {
            appError = inventoryError
        } else {
            appError = .unknown(error)
        }
    }
    
    
    // MARK: Product
    func addProduct(_ product: Product) {
        guard !product.name.isEmpty else {
            appError = .emptyName
            return
        }
        
        guard product.quantity > 0 else {
            appError = .emptyQuantity
            return
        }
        
        do {
            try inventoryService.createProduct(product)
        } catch {
            handleError(error)
        }
    }
    
    func deleteProduct(_ product: Product) {
        do {
            try inventoryService.deleteProduct(product)
        } catch {
            handleError(error)
        }
    }
    
    // MARK: Categories
    func addCategory(name: String) -> Bool {
        let cleanName = name.cleaned

        guard !cleanName.isEmpty else {
            appError = .emptyName
            return false
        }

        let category = ProductCategory(name: cleanName)

        do {
            try inventoryService.createCategory(category)
            return true
        } catch {
            handleError(error)
            return false
        }
    }
    
    func updateCategory(_ category: ProductCategory, name: String) {
        let cleanName = name.cleaned

        guard !cleanName.isEmpty else {
            appError = .emptyName
            return
        }

        category.name = cleanName

        do {
            try inventoryService.save()
        } catch {
            handleError(error)
        }
    }
    
    func deleteCategory(_ category: ProductCategory) {
        do {
            try inventoryService.deleteCategory(category)
        } catch {
            handleError(error)
        }
    }
    
    // MARK: Brand
    func addBrand(name: String,imageData: Data?) {
        
        let cleanName = name.cleaned
        
        guard !cleanName.isEmpty else {
            appError = .emptyName
            return
        }
        
        do {
            let brand = Brand(
                name: cleanName,
                imageData: imageData
            )
            try inventoryService.createBrand(brand)
        } catch {
            handleError(error)
        }
    }
    
    func updateBrand(_ brand: Brand,name: String,imageData: Data?) {
        let cleanName = name.cleaned

        guard !cleanName.isEmpty else {
            appError = .emptyName
            return
        }

        brand.name = cleanName
        brand.imageData = imageData

        do {
            try inventoryService.save()
        } catch {
            handleError(error)
        }
    }
    
    func deleteBrand(_ brand: Brand) {
        guard brand.products.isEmpty else {
            appError = .brandHasProducts(brand.name)
            return
        }
        do {
            try inventoryService.deleteBrand(brand)
        } catch {
            handleError(error)
        }
    }
}
