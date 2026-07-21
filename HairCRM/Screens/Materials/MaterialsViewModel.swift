//
//  MaterialsViewModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 21.07.2026.
//
import Foundation

final class MaterialsViewModel: ObservableObject {
    @Published var searchResults: [Material] = []
    
    @Published var categories: [MaterialCategory] = [
        MaterialCategory(id: UUID(), name: "Перманентный краситель"),
        MaterialCategory(id: UUID(), name: "Тонирующий краситель"),
        MaterialCategory(id: UUID(), name: "Окислители"),
        MaterialCategory(id: UUID(), name: "Блондирующие препараты"),
        MaterialCategory(id: UUID(), name: "Расходники"),
        MaterialCategory(id: UUID(), name: "Инструменты")
    ]
    
    
    @Published var searchText: String = "" {
        didSet {
            debounceSearchTask()
        }
    }
    
    @Published var recentSearches: [String] = []
    
    
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
        categories.append(MaterialCategory(id: UUID(), name: name))
    }
    
    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
}
