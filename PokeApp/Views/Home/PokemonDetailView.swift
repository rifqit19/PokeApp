//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let detail: PokemonDetail?

    var body: some View {
        ScrollView {
            if let d = detail {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(d.id).png")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 250, maxHeight: 250)
                                .shadow(radius: 10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(.top, 20)

                    Text(d.name.capitalized)
                        .font(.largeTitle)
                        .bold()

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Abilities")
                            .font(.title2)
                            .bold()
                        
                        ForEach(d.abilities, id: \.ability.name) { slot in
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.blue)
                                Text(slot.ability.name.capitalized)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    Spacer()
                }
            } else {
                Text("No detail available")
                    .foregroundColor(.gray)
                    .padding(.top, 100)
            }
        }
        .navigationTitle(detail?.name.capitalized ?? "Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            NotificationCenter.default.post(name: .toggleTabBar, object: true) 
        }
    }
}
