//
//  LoginView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//


import SwiftUI
import MBProgressHUD
import RxSwift

struct LoginView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("PokeApp").font(.largeTitle).bold()
                TextField("Email", text: $vm.email)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $vm.password)
                    .textFieldStyle(.roundedBorder)

                Button(action: {
                    HUD.show("Loading...")
                    vm.login { result in
                        HUD.hide()
                        switch result {
                        case .success(let user):
                            if let u = user {
                                session.login(user: u)
                            } else {
                                vm.error = "Invalid credentials"
                            }
                        case .failure(let err):
                            vm.error = err.localizedDescription
                        }
                    }
                }) {
                    Text("Login").frame(maxWidth: .infinity).padding().background(Color.blue).foregroundColor(.white).cornerRadius(8)
                }

                NavigationLink("Register", destination: RegisterView())

                if let e = vm.error {
                    Text(e).foregroundColor(.red).font(.footnote)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            
        }
    }
}
