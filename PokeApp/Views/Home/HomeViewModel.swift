//
//  HomeViewModel.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import RxSwift
import Combine

final class HomeViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private var offset = 0
    private let limit = 10

    @Published var pokemons: [PokemonListItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchResult: PokemonDetail?
    @Published var selectedDetail: PokemonDetail?
    @Published var navigateToDetail: Bool = false

    init() {
        let cache = RealmManager.shared.getCachedPokemonList()
        if !cache.isEmpty { pokemons = cache }
    }

    func loadInitial() {
        offset = 0
        pokemons = []
        loadMore()
    }

    func loadMore() {
        guard !isLoading else { return }
        isLoading = true
        ApiService.shared.fetchPokemonList(limit: limit, offset: offset)
            .subscribe(onNext: { [weak self] resp in
                guard let self = self else { return }
                let new = resp.results
                self.pokemons.append(contentsOf: new)
                do { try RealmManager.shared.cachePokemonList(new) } catch { print("cache err", error) }
                self.offset += self.limit
                self.isLoading = false
            }, onError: { [weak self] err in
                self?.isLoading = false
                self?.errorMessage = err.localizedDescription
            }).disposed(by: disposeBag)
    }

    func handleSearchSubmit(query: String) {
        let q = query.trimmingCharacters(in: .whitespaces).lowercased()
        if q.isEmpty {
            resetSearch()
        } else {
            searchPokemon(name: q)
        }
    }

    func resetSearch() {
        searchResult = nil
        loadInitial()
    }

    private func searchPokemon(name: String) {
        HUD.show("Loading...")
        ApiService.shared.fetchPokemonDetail(nameOrId: name)
            .subscribe(onNext: { detail in
                HUD.hide()
                do { try RealmManager.shared.cachePokemonDetail(detail) } catch { print("cache detail err", error) }
                DispatchQueue.main.async { self.searchResult = detail }
            }, onError: { err in
                HUD.hide()
                print("search err", err.localizedDescription)
                DispatchQueue.main.async { self.searchResult = nil }
            }).disposed(by: disposeBag)
    }

    func openDetail(_ detail: PokemonDetail) {
        selectedDetail = detail
        NotificationCenter.default.post(name: .toggleTabBar, object: false)
        navigateToDetail = true
    }

    func fetchDetailAndOpen(name: String) {
        HUD.show("Loading...")
        ApiService.shared.fetchPokemonDetail(nameOrId: name)
            .subscribe(onNext: { d in
                HUD.hide()
                self.openDetail(d)
            }, onError: { err in
                HUD.hide()
                print("detail err", err.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
