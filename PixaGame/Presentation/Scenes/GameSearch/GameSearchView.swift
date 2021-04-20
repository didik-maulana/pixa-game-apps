//
//  GameSearchView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct GameSearchView: View {
    
    @ObservedObject var gameSearchState = GameSearchState()
    
    var body: some View {
        NavigationView {
            List {
                Text("Search Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                
                SearchBarView(placeholder: "Search for a game", text: self.$gameSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.gameSearchState.isLoading, error: self.gameSearchState.error) {
                    self.gameSearchState.searchGame(query: self.gameSearchState.query)
                }
                
                if self.gameSearchState.games != nil {
                    GameSearchListView(games: self.gameSearchState.games ?? [])
                }
                
                if self.gameSearchState.isEmptySearch {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Search not found")
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .onAppear {
                self.gameSearchState.startObserve()
            }
        }
    }
}

struct GameSearchListView: View {
    let games: [Game]
    
    var body: some View {
        ForEach(self.games) { game in
            NavigationLink(destination: GameDetailView(id: game.id)) {
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(Font.system(size: 16))
                        .fontWeight(.bold)
                    
                    if !game.genreText.isEmpty {
                        Text(game.genreText)
                            .font(Font.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GameSearchView()
    }
}
