//
//  GameSectionView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct GameSectionView: View {
    
    var title: String? = nil
    let games: [Game]
    
    var body: some View {
        VStack(alignment: .leading) {
            if title != nil {
                Text(title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(self.games) { game in
                        NavigationLink(destination: GameDetailView(id: game.id)) {
                            GameCardView(game: game)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct GameSectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSectionView(title: "Trendings", games: Game.stubbedGames)
    }
}
