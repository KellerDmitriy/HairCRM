//
//  AppContainerKey.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 30.07.2026.
//


import SwiftUI

private struct AppContainerKey: EnvironmentKey {

    static let defaultValue: AppContainer? = nil
}


extension EnvironmentValues {

    var appContainer: AppContainer? {

        get {
            self[AppContainerKey.self]
        }

        set {
            self[AppContainerKey.self] = newValue
        }
    }
}