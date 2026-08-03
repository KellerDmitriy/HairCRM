//
//  AppContainer.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 30.07.2026.
//


import SwiftData

@MainActor
final class AppContainer {
    // MARK: - Services
    let swiftDataService: SwiftDataService
    let inventoryService: InventoryServiceProtocol

    // MARK: - INIT
    init(context: ModelContext) {
        let dataService = SwiftDataService(context: context)
        self.swiftDataService = dataService
        self.inventoryService = InventoryService(service: dataService)
    }
}
