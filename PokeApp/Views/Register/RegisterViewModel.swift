//
//  RegisterViewModel.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI
import RxSwift

final class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String?

    func register(completion: @escaping (Result<Void, Error>) -> Void) {
        AuthRepository.shared.register(name: name, email: email, password: password)
            .subscribe(onNext: { ok in
                if ok { completion(.success(())) } else { completion(.failure(NSError(domain: "", code: -1))) }
            }, onError: { err in
                completion(.failure(err))
            }).disposed(by: DisposeBag())
    }
}
