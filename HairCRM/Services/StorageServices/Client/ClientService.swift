//
//  ClientService.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//

import Foundation

final class ClientService: ClientServiceProtocol {
    // MARK: - Properties
    private let service: SwiftDataService

    // MARK: - Init
    init(service: SwiftDataService) {
        self.service = service
    }
    
    
    // MARK: - Client
    func createClient(_ client: ClientModel) throws {
       try service.insert(client)
    }

    func deleteClient(_ client: ClientModel) throws {
        try service.delete(client)
    }

    func updateClient(_ client: ClientModel) throws {
        try service.save()
    }
}
