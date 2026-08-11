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
        HStack {
            VStack(alignment: .leading) {
                Text(client.name)
                Text(client.surname)
                Text(client.phone)
            }
            Spacer()
        }
        .padding()
        .airbnbCerealFont(.medium, size: 20)
        .foregroundStyle(.secondary).opacity(0.8)
        .frame(width: .infinity, height: 90)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.white.opacity(0.08), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background(.appBackground)
    }
}

#Preview {
    ClientForm(client: ClientModel(id: UUID(), name: "Валентина", surname: "Фролова", phone: "89112344312"))
}
