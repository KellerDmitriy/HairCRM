//
//  VisitService.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//


import Foundation

@MainActor
final class VisitService: VisitServiceProtocol {

    // MARK: - Properties

    /// Общий сервис SwiftData.
    private let service: SwiftDataService

    // MARK: - Init

    init(service: SwiftDataService) {
        self.service = service
    }

    // MARK: - Close Visit

    func closeVisit(
        _ input: CloseVisitInput
    ) throws {
        do {
            // MARK: 1. Проверяем материалы
            
            for material in input.materials {
                
                guard material.quantity > 0 else {
                    throw InventoryError.emptyQuantity
                }
                
                guard material.product.quantity >= material.quantity else {
                    throw InventoryError.insufficientStock(
                        material.product.name
                    )
                }
            }
            
            
            // MARK: 2. Создаём Visit
            
            let visit = Visit(
                number: makeVisitNumber(),
                client: input.client,
                date: .now,
                totalAmount: input.totalAmount
            )
            
            
            // MARK: 3. Обрабатываем материалы
            
            var materialCost: Double = 0
            
            for material in input.materials {
                
                let product = material.product
                
                // Себестоимость одной единицы
                let unitCost = product.cost
                
                // Полная себестоимость этого материала
                let totalCost =
                unitCost * material.quantity
                
                materialCost += totalCost
                
                
                // MARK: Создаём историю расхода
                
                let usage = MaterialUsage(
                    number: makeMaterialUsageNumber(),
                    product: product,
                    quantity: material.quantity,
                    unit: product.unit,
                    unitCost: unitCost,
                    totalCost: totalCost,
                    visit: visit
                )
                
                visit.materialUsages.append(usage)
                
                
                // MARK: Списываем материал со склада
                
                product.quantity -= material.quantity
                
                try service.insert(usage)
            }
            
            
            // MARK: 4. Рассчитываем финансовый результат
            
            visit.materialCost = materialCost
            
            visit.profit =
            visit.totalAmount
            - visit.materialCost
            - visit.additionalCost
            
            
            // MARK: 5. Добавляем Visit
            
            try service.insert(visit)
            
            
            // MARK: 6. Сохраняем ВСЁ
            
            try service.save()
        } catch {
          
            // Отменяем все изменения,
            // сделанные в текущем ModelContext.
            service.rollback()

            throw error
        }
    }


    // MARK: - Persistence

    func save() throws {
        try service.save()
    }


    // MARK: - Numbers

    private func makeVisitNumber() -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"

        return "VIS-\(formatter.string(from: .now))"
    }


    private func makeMaterialUsageNumber() -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"

        return "MU-\(formatter.string(from: .now))"
    }
}
