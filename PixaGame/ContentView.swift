//
//  ContentView.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBarView {
            GameListView().tab(title: "Games", image: "gamecontroller")
            GameSearchView().tab(title: "Search", image: "magnifyingglass")
            FavoriteListView().tab(title: "Favorites", image: "heart")
            ProfileView().tab(title: "Profile", image: "person")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
