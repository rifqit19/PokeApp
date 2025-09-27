//
//  LoginViewModel.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI
import RxSwift

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String?

    func login(completion: @escaping (Result<UserObject?, Error>) -> Void) {
        AuthRepository.shared.login(email: email, password: password)
            .subscribe(onNext: { user in
                completion(.success(user))
            }, onError: { err in
                completion(.failure(err))
            }).disposed(by: DisposeBag())
    }
}
