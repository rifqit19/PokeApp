//
//  SessionManager.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import SwiftUI

final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    private init() {
        do {
            if let saved = UserDefaults.standard.string(forKey: "current_user_email") {
                if let user = RealmManager.shared.getUser(email: saved) {
                    currentUser = user
                    isLoggedIn = true
                }
            }
        } catch {
            print("Realm init error: \(error)")
        }
    }

    @Published var isLoggedIn: Bool = false
    @Published var currentUser: UserObject?

    func login(user: UserObject) {
        currentUser = user
        isLoggedIn = true
        UserDefaults.standard.set(user.email, forKey: "current_user_email")
    }

    func logout() {
        currentUser = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "current_user_email")
    }
}
