//
//  CloseVisitInput.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//


import Foundation

struct CloseVisitInput {

    /// Клиент, которому принадлежит визит.
    let client: ClientModel

    /// Сумма, которую заплатил клиент.
    let totalAmount: Double

    /// Материалы, использованные во время визита.
    let materials: [MaterialUsageInput]
}