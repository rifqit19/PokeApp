//
//  ApiService.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import Alamofire
import RxSwift

final class ApiService {
    static let shared = ApiService()
    private init() {}

    private let base = "https://pokeapi.co/api/v2"

    func fetchPokemonList(limit: Int, offset: Int) -> Observable<PokemonListResponse> {
        let url = "\(base)/pokemon?limit=\(limit)&offset=\(offset)"
        return request(url)
    }

    func fetchPokemonDetail(nameOrId: String) -> Observable<PokemonDetail> {
        let url = "\(base)/pokemon/\(nameOrId)"
        return request(url)
    }

    private func request<T: Decodable>(_ url: String) -> Observable<T> {
        Observable.create { observer in
            let req = AF.request(url)
                .validate()
                .responseDecodable(of: T.self) { resp in
                    switch resp.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let err):
                        observer.onError(err)
                    }
                }
            return Disposables.create { req.cancel() }
        }
    }
}
