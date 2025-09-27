//
//  PokeAppApp.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI
import RealmSwift

@main
struct PokeAppApp: SwiftUI.App {
    init() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
    }

    var body: some Scene {
        WindowGroup {
            RootView()
            
        }
    }
}
