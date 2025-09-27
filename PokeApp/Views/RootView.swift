//
//  RootView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var session = SessionManager.shared

    var body: some View {
        Group {
            if session.isLoggedIn, let user = session.currentUser {
                LandingView()
                    .environmentObject(session)
            } else {
                LoginView()
                    .environmentObject(session)
            }
        }
        .onAppear{
            print("Session.isLoggedIn = \(session.isLoggedIn), user = \(String(describing: session.currentUser))")
        }
        
    }
}
