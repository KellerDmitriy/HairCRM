//
//  ClientViewModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//
import Foundation

@MainActor
final class ClientViewModel: ObservableObject {
    let clientService: ClientServiceProtocol
    @Published var appError: InventoryError?
    
    // MARK: - Init
    init(clientService: ClientServiceProtocol) {
        self.clientService = clientService
    }
    
    // MARK: - Handle Error
    private func handleError(_ error: Error) {
        if let inventoryError = error as? InventoryError {
            appError = inventoryError
        } else {
            appError = .unknown(error)
        }
    }
    
    // MARK: Client
    func addNewClient(_ client: ClientModel) {
        
        do {
            try clientService.createClient(client)
        } catch {
            handleError(error)
        }
    }
    
}
