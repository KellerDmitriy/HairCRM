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
    
//    MARK: Categories
    func addCategory(name: String) {
        let category = ProductCategory(name: name)
        try? inventoryService.createCategory(category)
    }
}
