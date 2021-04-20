//
//  GameDetailView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct GameDetailView: View {
    
    let id: Int
    @ObservedObject private var gameDetailState = GameDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: gameDetailState.isLoading, error: gameDetailState.error) {
                self.gameDetailState.loadGame(id: self.id)
            }
            
            if gameDetailState.game != nil {
                GameDetailListView(game: gameDetailState.game ?? Game.stubbedGameDetail, gameDetailState: self.gameDetailState)
            }
        }
        .navigationBarTitle(gameDetailState.game?.name ?? "")
        .onAppear {
            self.gameDetailState.loadGame(id: self.id)
        }
    }
}

struct GameDetailListView: View {
    
    let game: Game
    @ObservedObject var gameDetailState: GameDetailState
    
    var body: some View {
        List {
            GameImageView(imageURL: game.backgroundURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(game.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                if !game.genreText.isEmpty {
                    Text(game.genreText)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Text("Released \(game.releasedText)")
                    .font(Font.system(size: 14))
                    .foregroundColor(.gray)
            }
            .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            
            Button(action: {
                if self.game.isFavorite == true {
                    self.gameDetailState.removeFavorite()
                } else {
                    self.gameDetailState.addFavorite()
                }
            }) {
                GameFavoriteButtonView(isFavorite: self.game.isFavorite)
            }
            .buttonStyle(PlainButtonStyle())
            .listRowInsets(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
            
            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("Game Description")
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)

                Text(game.descriptionRaw ?? "-")
                    .font(Font.system(size: 14))
                    .multilineTextAlignment(.leading)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
            Divider()
            
            HStack(alignment: .top) {
                GameInformationView(title: "Rating", description: game.ratingWithStarText)
                Spacer()
                GameInformationView(title: "Suggestions", description: game.suggestionsCountText)
                Spacer()
                GameInformationView(title: "Reviews", description: game.reviewsCountText)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
            Divider()
            
            HStack(alignment: .top) {
                GameInformationListView(title: "Publishers", items: game.publisherNames)
                Spacer()
                GameInformationListView(title: "Developers", items: game.developerNames)
                Spacer()
                GameInformationListView(title: "Platforms", items: game.platformNames)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}

struct GameImageView: View {
    
    let imageURL: URL?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(imageURL: self.imageURL)
            
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
                    startPoint: .bottom, endPoint: .top))
                .frame(height: 150)
        }
        .frame(height: 250)
        .cornerRadius(radius: 40, corners: .bottomRight)
    }
}

struct GameFavoriteButtonView: View {
    
    let isFavorite: Bool?
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            ZStack(alignment: .center) {
                Circle()
                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
                
                Image(systemName: self.isFavorite == true ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 16, height: 14)
                    .foregroundColor(self.isFavorite == true ? .red : Color.black.opacity(0.6))
            }
            .frame(width: 30, height: 30)
            
            Text("Favorite")
                .font(Font.system(size: 12))
                .foregroundColor(Color.black.opacity(0.8))
                .padding(.top, 2)
        }
    }
}

struct GameInformationView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(Font.system(size: 16))
            Text(description)
                .font(Font.system(size: 14))
        }
    }
}

struct GameInformationListView: View {
    let title: String
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(Font.system(size: 16))
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            if self.items.isEmpty {
                Text("-")
            } else {
                ForEach(self.items.indices) { index in
                    Text(self.items[index])
                        .font(Font.system(size: 14))
                }
            }
        }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetailView(id: Game.stubbedGame.id)
        }
    }
}
