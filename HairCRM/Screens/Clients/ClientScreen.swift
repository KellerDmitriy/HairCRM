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
    
    @State private var mode: ClientMode?
    @State private var clientToDelete: ClientModel?
    
    @State private var showAddClient = false
    @State private var showSearchFlow = false
    
    
    // MARK: - Init
    init(viewModel: ClientViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        List {
            if clients.isEmpty {
                AppFormCard {
                    Text(Resources.Text.addNewClient)
                }
                .listRowBackground(Color.clear)
            }
            
            ForEach(clients) { client in
                ClientForm(client: client)
                    .swipeActions(
                        edge: .trailing,
                        allowsFullSwipe: false
                    ) {
                        // MARK: - Swipe Actions
                        // Delete
                        Button(role: .destructive) {
                            clientToDelete = client
                        } label: {
                            Label(
                                Resources.Text.delete,
                                systemImage: "trash"
                            )
                        }
                        
                        // Edit
                        Button {
                            mode = .edit(client)
                            showAddClient = true
                        } label: {
                            Label(
                                Resources.Text.edit,
                                systemImage: "pencil"
                            )
                        }
                        .tint(.blue)
                    }
            }
            
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolBarButton(icon: .plus) {
                    mode = .create
                    showAddClient = true
                }
            }
            
            ToolbarItem(placement: .principal) {
                ToolBarTitleView(title: Resources.Text.client.localized)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarButton(icon: .searchWhite) { showSearchFlow = true }
            }
        }
        .alert(
            "Удалить клиента?",
            isPresented: Binding(
                get: { clientToDelete != nil },
                set: { if !$0 { clientToDelete = nil } }
            )
        ) {
            Button("Удалить", role: .destructive) {
                if let client = clientToDelete {
                    viewModel.deleteClient(client)
                }
                clientToDelete = nil
            }
            Button("Отмена", role: .cancel) {
                clientToDelete = nil
            }
        } message: {
            Text("Карточка клиента будет удалена")
        }
        
        .sheet(isPresented: $showAddClient) {
           
            AddClientSheet(
                viewModel: viewModel,
                mode: mode ?? .create
            )
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    let schema = Schema([
        Brand.self,
        Product.self,
        ProductCategory.self,
        ProductGroup.self,
        ClientModel.self
    ])
    
    let configuration: ModelConfiguration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
    )
    
    let modelContainer: ModelContainer = try! ModelContainer(
        for: schema,
        configurations: [configuration]
    )
    
    let context = modelContainer.mainContext
    
    let clients: [ClientModel] = [
        ClientModel(
            name: "Александр",
            surname: "Иванов",
            phone: "+79991234567",
            dateOfBirth: .now,
            notes: "Постоянный клиент"
        ),
        ClientModel(
            name: "Елена",
            surname: "Петрова",
            phone: "+79997654321",
            dateOfBirth: .now
        ),
        ClientModel(
            name: "Михаил",
            surname: "Смирнов",
            phone: "+79995554433"
        )
    ]
    
    for client in clients {
        context.insert(client)
    }
    
    let appContainer = AppContainer(context: context)
    
    return
    NavigationStack {
        ClientScreen()
            .modelContainer(modelContainer)
            .environment(\.appContainer, appContainer)
    }
}
