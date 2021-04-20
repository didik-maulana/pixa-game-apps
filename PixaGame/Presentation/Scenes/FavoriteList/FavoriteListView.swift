//
//  FavoriteListView.swift
//  PixaGame
//
//  Created by Didik on 18/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct FavoriteListView: View {
    
    @ObservedObject private var favoriteListState = FavoriteListState()
    
    var body: some View {
        NavigationView {
            ZStack {
                if favoriteListState.games != nil && favoriteListState.games?.isEmpty == false {
                    List {
                        GameSectionView(games: favoriteListState.games ?? [])
                            .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Favorite is empty")
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Favorites", displayMode: .inline)
            .onAppear {
                self.favoriteListState.getAllFavorite()
            }
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView()
    }
}
