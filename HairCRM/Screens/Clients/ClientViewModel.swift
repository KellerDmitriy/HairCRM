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
    
    // MARK: - Init
    init(clientService: ClientServiceProtocol) {
        self.clientService = clientService
    }
    
    
}
