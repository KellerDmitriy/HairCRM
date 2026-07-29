//
//  MaterialsViewModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//
import Foundation

final class MaterialsViewModel: ObservableObject {
    @Published var searchResults: [Product] = []
    
    @Published var categories: [ProductCategory] = [
        ProductCategory(id: UUID(), name: "Перманентный краситель"),
        ProductCategory(id: UUID(), name: "Тонирующий краситель"),
        ProductCategory(id: UUID(), name: "Окислители"),
        ProductCategory(id: UUID(), name: "Блондирующие препараты"),
        ProductCategory(id: UUID(), name: "Уход за волосами"),
        ProductCategory(id: UUID(), name: "Расходники"),
        ProductCategory(id: UUID(), name: "Инструменты")
    ]
    
    
    @Published var searchText: String = "" {
        didSet {
            debounceSearchTask()
        }
    }
    
    @Published var recentSearches: [String] = []
    @Published var products: [Product] = []
    
    // MARK: - Вebounce Search Task
    private func debounceSearchTask() {
//        currentSearchTask?.cancel()
//        currentSearchTask = Task {
//            try? await Task.sleep(nanoseconds: 300_000_000)
//            
//            guard !Task.isCancelled else { return }
//            if searchText.isEmpty {
//                searchResults = []
//            }
//            if searchScreenType == .withData {
//                filterLocalData()
//            } else {
//                await fetchSearchedEvents()
//            }
//        }
    }
    
//    MARK: Categories
    func addCategory(name: String) {
        categories.append(ProductCategory(id: UUID(), name: name))
    }
    
    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
}
