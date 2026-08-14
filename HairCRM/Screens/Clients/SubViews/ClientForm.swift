//
//  ClientForm.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//

import SwiftUI

struct ClientForm: View {
    
    let client: ClientModel
    
    // MARK: - Body
    var body: some View {
        AppFormCard {
            HStack {
                VStack(alignment: .leading) {
                    Text(client.name)
                    Text(client.surname)
                    Text(client.phone)
                }
                Spacer()
            }
            .airbnbCerealFont(.medium, size: 20)
            .foregroundStyle(.secondary).opacity(0.8)
        }
    }
}

#Preview {
    ClientForm(client: ClientModel(id: UUID(), name: "Валентина", surname: "Фролова", phone: "89112344312"))
}
