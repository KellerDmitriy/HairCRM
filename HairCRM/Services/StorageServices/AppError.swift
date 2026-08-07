//
//  AppError.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//


import Foundation

enum AppError: LocalizedError {

    case saveFailed
    case createFailed
    case deleteFailed
    case invalidData(String)

    var errorDescription: String? {

        switch self {

        case .saveFailed:
            return "Не удалось сохранить данные"

        case .createFailed:
            return "Не удалось создать объект"

        case .deleteFailed:
            return "Не удалось удалить объект"

        case .invalidData(let message):
            return message
        }
    }
}