//
//  ProductRepositoryProtocol.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 29.07.2026.
//


import Foundation

protocol ProductRepositoryProtocol {

    // Create
    func create(_ product: Product) throws

    // Read
    func fetchAll() throws -> [Product]

    func fetch(by id: UUID) throws -> Product?

    // Update
    func save() throws

    // Delete
    func delete(_ product: Product) throws
}