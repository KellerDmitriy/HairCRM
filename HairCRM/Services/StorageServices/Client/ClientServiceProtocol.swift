//
//  InventoryServiceProtocol.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//


import Foundation

@MainActor
protocol ClientServiceProtocol {

    // MARK: - Client
    func createClient(_ client: ClientModel) throws
    func deleteClient(_ client: ClientModel) throws
    func updateClient(_ client: ClientModel) throws
}
