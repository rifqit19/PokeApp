//
//  RegisterView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI
import MBProgressHUD
import RxSwift

struct RegisterView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject private var vm = RegisterViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            TextField("Name", text: $vm.name).textFieldStyle(.roundedBorder)
            TextField("Email", text: $vm.email).autocapitalization(.none).textFieldStyle(.roundedBorder)
            SecureField("Password", text: $vm.password).textFieldStyle(.roundedBorder)
            
            Button("Register") {
                HUD.show("Loading...")
                vm.register { result in
                    HUD.hide()
                    switch result {
                    case .success:
                        presentation.wrappedValue.dismiss()
                    case .failure(let err):
                        vm.error = err.localizedDescription
                    }
                }
            }
            .frame(maxWidth: .infinity).padding().background(Color.green).foregroundColor(.white).cornerRadius(8)
            
            if let e = vm.error { Text(e).foregroundColor(.red) }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
    }
}

