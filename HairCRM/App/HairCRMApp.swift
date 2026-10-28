//
//  HairCRMApp.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 27.06.2025.
//


import SwiftUI
import SwiftData


@main
struct HairCRMApp: App {

    var body: some Scene {

        WindowGroup {
            ContentView()
           

        }
        .modelContainer(
            for: [
                Product.self,
                ProductCategory.self,
                ProductGroup.self,
                Brand.self,

                ClientModel.self,
                Visit.self,
                MaterialUsage.self,
               
            ]
        )
    }
}
