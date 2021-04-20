//
//  FavoriteListState.swift
//  PixaGame
//
//  Created by Didik on 22/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

class FavoriteListState: ObservableObject {
    
    @Published var games: [Game]?
    
    private var favoriteRepository: FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository = GameLocalDataSource.shared) {
        self.favoriteRepository = favoriteRepository
    }
    
    func getAllFavorite() {
        favoriteRepository.getAllFavorite { [weak self] (games, error) in
            guard let self = self else { return }
            
            if error != nil {
                print(error?.localizedDescription ?? "Could not get all favorite")
                return
            }
            
            DispatchQueue.main.async {
                self.games = games
            }
        }
    }
}
