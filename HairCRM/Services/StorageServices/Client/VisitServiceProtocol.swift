//
//  VisitServiceProtocol.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//


import Foundation

@MainActor
protocol VisitServiceProtocol {

    /// Полностью закрывает визит:
    /// создаёт Visit,
    /// списывает материалы,
    /// создаёт MaterialUsage,
    /// рассчитывает себестоимость,
    /// сохраняет всё одной операцией.
    func closeVisit(
        _ input: CloseVisitInput
    ) throws

    /// Сохраняет изменения SwiftData.
    func save() throws
}
