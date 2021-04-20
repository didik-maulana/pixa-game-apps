//
//  GameCarouselView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct GameCarouselView: View {
    
    let title: String
    let games: [Game]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.games.prefix(6)) { game in
                        NavigationLink(destination: GameDetailView(id: game.id)) {
                            GameCarouselItemView(game: game)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, game.id == self.games.first?.id ? 16 : 0)
                        .padding(.trailing, game.id == self.games.last?.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct GameCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        GameCarouselView(title: "Top Rated", games: Game.stubbedGames)
    }
}
