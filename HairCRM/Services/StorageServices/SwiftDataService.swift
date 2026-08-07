//
//  SwiftDataService.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 31.07.2026.
//

import SwiftData

@MainActor
final class SwiftDataService {

    private let context: ModelContext


    init(
        context: ModelContext
    ) {
        self.context = context
    }


    func insert<T: PersistentModel>(
        _ object: T
    ) throws {
        context.insert(object)
        try context.save()
    }


    func delete<T: PersistentModel>(
        _ object: T
    ) throws {
        context.delete(object)
        try context.save()
    }
    
    func save() throws {
        try context.save()
    }
}
