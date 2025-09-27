//
//  HomeView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var searchText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                HStack(spacing: 8) {
                    TextField("Search pokemon by name", text: $searchText)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onSubmit { vm.handleSearchSubmit(query: searchText) }

                    Button(action: { vm.handleSearchSubmit(query: searchText) }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            vm.resetSearch()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 4)
                        }
                    }
                }
                .padding(.horizontal, 20)

                LazyVStack(spacing: 12) {
                    if let result = vm.searchResult {
                        pokemonCard(name: result.name) { vm.openDetail(result) }
                    } else {
                        ForEach(vm.pokemons, id: \.name) { p in
                            pokemonCard(name: p.name) {
                                vm.fetchDetailAndOpen(name: p.name)
                            }
                            .onAppear {
                                if p == vm.pokemons.last {
                                    vm.loadMore()
                                }
                            }
                        }

                        if vm.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                }
                .padding()
            }
            .background(
                NavigationLink(
                    destination: Group {
                        if let detail = vm.selectedDetail {
                            PokemonDetailView(detail: detail)
                        }
                    },
                    isActive: $vm.navigateToDetail
                ) { EmptyView() }
            )
        }
        .navigationTitle("Pokemons")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { if vm.pokemons.isEmpty { vm.loadInitial() } }
    }

    private func pokemonCard(name: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(name.capitalized)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}
