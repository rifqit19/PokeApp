//
//  AuthRepository.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import RxSwift

final class AuthRepository {
    static let shared = AuthRepository()
    private init() {}

    func register(name: String, email: String, password: String) -> Observable<Bool> {
        Observable.create { observer in
            do {
                try RealmManager.shared.saveUser(email: email, password: password, name: name)
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }

    func login(email: String, password: String) -> Observable<UserObject?> {
        Observable.create { observer in
            if let user = RealmManager.shared.getUser(email: email), user.password == password {
                observer.onNext(user)
            } else {
                observer.onNext(nil)
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
}
