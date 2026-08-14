//
//  ClientModel.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//

import SwiftData
import Foundation

@Model
final class ClientModel {
    var id: UUID
    var name: String
    var surname: String
    var nikname: String?
    var phone: String
    var notes: String?
    
    
    init(
        id: UUID = UUID(),
        name: String,
        surname: String,
        nikname: String? = nil,
        phone: String,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.nikname = nikname
        self.phone = phone
        self.notes = notes
    }
    
}

