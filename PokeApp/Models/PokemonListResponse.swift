//
//  PokemonListResponse.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import RealmSwift

// Network models
struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable, Equatable {
    let name: String
    let url: String
}

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let abilities: [AbilitySlot]
}

struct AbilitySlot: Decodable {
    let ability: AbilityRef
}

struct AbilityRef: Decodable {
    let name: String
    let url: String
}

// Realm models
class RealmPokemonListItem: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    override static func primaryKey() -> String? { "name" }
    convenience init(_ item: PokemonListItem) {
        self.init()
        self.name = item.name
        self.url = item.url
    }
}

class RealmPokemonDetail: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    let abilities = List<String>()
    override static func primaryKey() -> String? { "id" }

    convenience init(_ d: PokemonDetail) {
        self.init()
        self.id = d.id
        self.name = d.name
        self.abilities.append(objectsIn: d.abilities.map { $0.ability.name })
    }
}

class UserObject: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var name: String = ""
    override static func primaryKey() -> String? { "email" }
}
