//
//  GameListView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct GameListView: View {

    @ObservedObject private var popularState = GameListState()
    @ObservedObject private var gameListState = GameListState()
    
    var body: some View {
        NavigationView {
            List {
                HeaderView()
                    .listRowInsets(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))

                Group {
                    if popularState.games != nil {
                        GameCarouselView(title: "Most Popular", games: popularState.games ?? [])
                    } else {
                        LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                            self.popularState.loadGames()
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))

                Group {
                    if gameListState.games != nil {
                        GameSectionView(title: "Browse the games", games: gameListState.games ?? [])
                    } else {
                        LoadingView(isLoading: gameListState.isLoading, error: gameListState.error) {
                            self.gameListState.loadGames()
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))

            }
            .navigationBarTitle("PixaGame", displayMode: .inline)
            .onAppear {
                if self.popularState.games == nil {
                    self.popularState.loadGames()
                }

                if self.gameListState.games == nil {
                    self.gameListState.loadGames(page: 2)
                }
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hai, Didik")
                .font(Font.system(size: 20))
                .fontWeight(.bold)
            
            Text("Explore your favorite games")
                .foregroundColor(.gray)
                .font(Font.system(size: 14))
                .padding(.top, 4)
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
            .previewDevice(PreviewDevice.init(rawValue: "iPhone 8"))
    }
}
