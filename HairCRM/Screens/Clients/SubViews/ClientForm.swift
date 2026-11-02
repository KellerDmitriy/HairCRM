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
                    Text("\(Resources.Text.fio): \(client.name) \(client.surname)")
           
                    Text("\(Resources.Text.phone): \(client.phone)")
                    
                    Text("\(Resources.Text.dateOfBirth): \(client.dateOfBirth?.formatted() ?? Resources.Text.noDate)")
                    
                    Text("\(Resources.Text.dateOfVisit): \(client.dateOfVisit?.formatted() ?? Resources.Text.noDate)")
                }
                Spacer()
            }
            .airbnbCerealFont(.medium, size: 20)
            .foregroundStyle(.secondary).opacity(0.8)
        }
        .frame(width: .infinity, height: 300)
    }
}

#Preview {
    ClientForm(client: ClientModel(id: UUID(), name: "Валентина", surname: "Фролова", phone: "89112344312"))
}
