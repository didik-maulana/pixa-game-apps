//
//  GameCarouselItemView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct GameCarouselItemView: View {
    
    let game: Game
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(imageURL: self.game.backgroundURL)
            
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
                    startPoint: .bottom, endPoint: .top))
                .frame(height: 80)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    
                Text(game.ratingWithStarText)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(width: 270, height: 180)
        .aspectRatio(16/9, contentMode: .fill)
        .cornerRadius(8)
    }
}

struct GameCarouselItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameCarouselItemView(game: Game.stubbedGame)
            .previewLayout(.sizeThatFits)
    }
}
