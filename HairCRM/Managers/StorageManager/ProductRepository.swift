//
//  ProductRepository.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 29.07.2026.
//


import SwiftData
import Foundation

final class ProductRepository: ProductRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func create(_ product: Product) throws {

        context.insert(product)

        try context.save()
    }

    func fetchAll() throws -> [Product] {

        let descriptor = FetchDescriptor<Product>(
            sortBy: [
                SortDescriptor(\.name)
            ]
        )

        return try context.fetch(descriptor)
    }

    func fetch(by id: UUID) throws -> Product? {

        let descriptor = FetchDescriptor<Product>(
            predicate: #Predicate {

                $0.id == id

            }
        )

        return try context.fetch(descriptor).first
    }

    func save() throws {

        try context.save()
    }

    func delete(_ product: Product) throws {

        context.delete(product)

        try context.save()
    }
}
