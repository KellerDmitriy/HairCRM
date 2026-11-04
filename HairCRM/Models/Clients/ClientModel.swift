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
    var phone: String
    var dateOfBirth: Date?
    var notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        surname: String,
        phone: String,
        dateOfBirth: Date? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.notes = notes
    }
}

