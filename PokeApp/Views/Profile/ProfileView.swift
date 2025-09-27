//
//  ProfileView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text(vm.name).font(.title2).bold()
                Text(vm.email).foregroundColor(.secondary)

                Button("Logout") {
                    session.logout()
                }
                .frame(maxWidth: .infinity)
                .padding().background(Color.red).foregroundColor(.white).cornerRadius(8)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}
