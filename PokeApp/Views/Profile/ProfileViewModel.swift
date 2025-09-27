//
//  ProfileViewModel.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""

    init() {
        if let user = SessionManager.shared.currentUser {
            name = user.name
            email = user.email
        }
    }
}
