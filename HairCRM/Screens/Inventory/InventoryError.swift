//
//  InventoryError.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//


import Foundation

enum InventoryError: LocalizedError, Identifiable {

    case emptyName
    case emptyQuantity

    case duplicateBrand(String)

    case brandHasProducts(String)

    case saveFailed
    case deleteFailed

    case unknown(Error)


    var id: String {
        localizedDescription
    }


    var errorDescription: String? {
        switch self {

        case .emptyName:
            return "Введите название"

        case .emptyQuantity:
            return "Укажите количество"

        case .duplicateBrand(let name):
            return "Бренд \(name) уже существует"

        case .brandHasProducts(let name):

            return """
            Нельзя удалить бренд \(name),
            так как есть связанные товары.
            Сначала удалите или измените товары.
            """

        case .saveFailed:
            return "Не удалось сохранить данные"

        case .deleteFailed:
            return "Не удалось удалить объект"

        case .unknown(let error):

            return error.localizedDescription
        }
    }
}
