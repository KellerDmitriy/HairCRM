//
//  MaterialUsage.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 11.08.2026.
//


import SwiftData
import Foundation

@Model
final class MaterialUsage {

    // MARK: - Идентификаторы

    /// Уникальный технический идентификатор записи.
    /// Используется внутри базы данных и связей между моделями.
    var id: UUID

    /// Человекочитаемый номер расхода.
    /// Например: "MU-000001".
    /// Удобен для отображения, поиска и будущих документов.
    var number: String


    // MARK: - Материал

    /// Материал, который был использован.
    /// Например: Goldwell Topchic 7N.
    var product: Product?


    // MARK: - Количество

    /// Количество использованного материала.
    /// Например: 35.0 грамм.
    var quantity: Double

    /// Единица измерения материала.
    /// Например: граммы, миллилитры или штуки.
    var unit: ProductUnit


    // MARK: - Себестоимость

    /// Себестоимость единицы материала на момент использования.
    /// Важно сохранять именно это значение,
    /// потому что цена материала на складе в будущем может измениться.
    ///
    /// Например:
    /// сегодня 1 г красителя стоит 8 ₽,
    /// использовали 30 г → себестоимость = 240 ₽.
    var unitCost: Double

    /// Полная себестоимость использованного материала.
    ///
    /// Например:
    /// 30 г × 8 ₽ = 240 ₽.
    var totalCost: Double


    // MARK: - Дата

    /// Дата и время использования материала.
    var createdAt: Date


    // MARK: - Связь с визитом

    /// Визит клиента, в рамках которого был использован материал.
    var visit: Visit?


    // MARK: - Init

    init(
        id: UUID = UUID(),
        number: String,
        product: Product? = nil,
        quantity: Double,
        unit: ProductUnit,
        unitCost: Double,
        totalCost: Double,
        createdAt: Date = .now,
        visit: Visit? = nil
    ) {
        self.id = id
        self.number = number
        self.product = product
        self.quantity = quantity
        self.unit = unit
        self.unitCost = unitCost
        self.totalCost = totalCost
        self.createdAt = createdAt
        self.visit = visit
    }
}