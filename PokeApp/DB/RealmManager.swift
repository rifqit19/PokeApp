//
//  RealmManager.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    private init() {}

    private var realmInstance: Realm?

    var realm: Realm {
        if let r = realmInstance { return r }
        do {
            let r = try Realm()
            realmInstance = r
            return r
        } catch {
            fatalError("Failed to init Realm: \(error)")
        }
    }

    // User
    func saveUser(email: String, password: String, name: String) throws {
        let user = UserObject()
        user.email = email
        user.password = password
        user.name = name
        try realm.write { realm.add(user, update: .modified) }
    }

    func getUser(email: String) -> UserObject? {
        realm.object(ofType: UserObject.self, forPrimaryKey: email)
    }

    // Pokemon list cache
    func cachePokemonList(_ items: [PokemonListItem]) throws {
        try realm.write {
            for i in items {
                realm.add(RealmPokemonListItem(i), update: .modified)
            }
        }
    }

    func getCachedPokemonList() -> [PokemonListItem] {
        realm.objects(RealmPokemonListItem.self).map { PokemonListItem(name: $0.name, url: $0.url) }
    }

    // Pokemon detail
    func cachePokemonDetail(_ d: PokemonDetail) throws {
        try realm.write { realm.add(RealmPokemonDetail(d), update: .modified) }
    }

    func getCachedPokemonDetail(id: Int) -> PokemonDetail? {
        guard let obj = realm.object(ofType: RealmPokemonDetail.self, forPrimaryKey: id) else { return nil }
        return PokemonDetail(
            id: obj.id,
            name: obj.name,
            abilities: obj.abilities.map { AbilitySlot(ability: AbilityRef(name: $0, url: "")) }
        )
    }
    
}
