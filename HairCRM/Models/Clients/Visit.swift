//
//  Visit.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//


import SwiftData
import Foundation

@Model
final class Visit {

    // MARK: - Идентификаторы

    /// Уникальный технический идентификатор визита.
    var id: UUID

    /// Человекочитаемый номер визита.
    /// Например: "VIS-000001".
    /// Можно использовать в истории, чеках и документах.
    var number: String


    // MARK: - Клиент

    /// Клиент, который пришёл на этот визит.
    var client: ClientModel?


    // MARK: - Дата

    /// Дата и время начала визита.
    var date: Date


    // MARK: - Финансы

    /// Сумма, которую клиент заплатил за визит.
    ///
    /// Например:
    /// окрашивание = 8 000 ₽
    /// продажа шампуня = 2 500 ₽
    /// итого = 10 500 ₽.
    var totalAmount: Double

    /// Общая себестоимость материалов,
    /// использованных в рамках этого визита.
    ///
    /// Например:
    /// краситель = 400 ₽
    /// оксид = 150 ₽
    /// уход = 300 ₽
    /// итого = 850 ₽.
    var materialCost: Double

    /// Дополнительные расходы по визиту.
    /// Пока можно оставить 0.
    /// В будущем сюда можно добавить, например,
    /// комиссию эквайринга или другие расходы.
    var additionalCost: Double

    /// Прибыль по визиту.
    ///
    /// Рассчитывается:
    /// totalAmount - materialCost - additionalCost
    var profit: Double


    // MARK: - Материалы

    /// Все материалы, которые были списаны со склада
    /// во время этого визита.
    ///
    /// Например:
    /// - Goldwell Topchic 7N — 30 г
    /// - Goldwell Oxidant — 45 мл
    /// - уход — 10 мл
    @Relationship(deleteRule: .cascade, inverse: \MaterialUsage.visit)
    var materialUsages: [MaterialUsage]


    // MARK: - Init

    init(
        id: UUID = UUID(),
        number: String,
        client: ClientModel? = nil,
        date: Date = .now,
        totalAmount: Double = 0,
        materialCost: Double = 0,
        additionalCost: Double = 0,
        profit: Double = 0,
        materialUsages: [MaterialUsage] = []
    ) {
        self.id = id
        self.number = number
        self.client = client
        self.date = date
        self.totalAmount = totalAmount
        self.materialCost = materialCost
        self.additionalCost = additionalCost
        self.profit = profit
        self.materialUsages = materialUsages
    }
}