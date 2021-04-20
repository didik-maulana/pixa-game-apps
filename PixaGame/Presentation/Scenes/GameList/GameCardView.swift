//
//  GameCardView.swift
//  PixaGame
//
//  Created by Didik on 11/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI
import URLImage

struct GameCardView: View {
    
    let game: Game
    
    var body: some View {
        HStack(alignment: .top) {
            ImageLoaderView(imageURL: self.game.backgroundURL)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(game.releasedText)
                    .font(Font.system(size: 16))
                    .padding(.top, 12)
                    .foregroundColor(.gray)
                
                Text("\(game.ratingWithStarText)")
                    .font(Font.system(size: 14))
                    .padding(.top, 20)
            }
            .padding(.leading, 8)
            .padding(.trailing, 4)
        }
        .frame(height: 100)
        .cornerRadius(8)
    }
}

struct GameCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView(game: Game.stubbedGame)
            .previewLayout(.sizeThatFits)
    }
}
