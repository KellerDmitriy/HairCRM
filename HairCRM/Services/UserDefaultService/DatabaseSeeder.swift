//
//  DatabaseSeeder.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 03.08.2026.
//


import Foundation

@MainActor
final class DatabaseSeeder {

    private let inventoryService: InventoryServiceProtocol


    init(
        inventoryService: InventoryServiceProtocol
    ) {
        self.inventoryService = inventoryService
    }


    func seedIfNeeded() {

        let defaults = UserDefaults.standard

        let hasSeeded = defaults.bool(
            forKey: AppSettings.hasSeededDefaultData
        )


        guard !hasSeeded else {
            return
        }

        createDefaultCategories()

        defaults.set(
            true,
            forKey: AppSettings.hasSeededDefaultData
        )
    }


    private func createDefaultCategories() {

        let categories = [
            "Перманентный краситель",
            "Тонирующий краситель",
            "Окислители",
            "Блондирующие препараты",
            "Уход за волосами",
            "Расходники",
            "Инструменты"
        ]


        for name in categories {

            let category = ProductCategory(
                name: name
            )

            try? inventoryService.createCategory(
                category
            )
        }
    }
}
