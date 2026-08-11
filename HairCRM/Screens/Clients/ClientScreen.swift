//
//  ClientsScreen.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//

import SwiftUI
import SwiftData

struct ClientScreen: View {
    @Environment(\.appContainer)
    private var container
    
    // MARK: - Body
    var body: some View {
        if let container {
            ClientContent(
                viewModel: ClientViewModel(clientService: container.clientService
                )
            )
        }
    }
}

struct ClientContent: View {
    
    @StateObject
    private var viewModel: ClientViewModel
    
    @Query(sort: \ClientModel.name)
    private var clients: [ClientModel]
    
    
    @State private var showAddClient = false
    @State private var showSearchFlow = false
    
    
    // MARK: - Init
    init(viewModel: ClientViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    // MARK: - Body
    var body: some View {
        VStack {
            ForEach(clients) { client in
                ClientForm(client: client)
            }
        }
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolBarButton(icon: .plus) {  showAddClient = true }
            }
            
            ToolbarItem(placement: .principal) {
                ToolBarTitleView(title: Resources.Text.client.localized)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarButton(icon: .searchWhite) { showSearchFlow = true }
            }
        }
    }
}

#Preview {
    ClientScreen()
}
