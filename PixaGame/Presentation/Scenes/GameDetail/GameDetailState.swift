//
//  GameDetailState.swift
//  PixaGame
//
//  Created by Didik on 08/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

class GameDetailState: ObservableObject {
    
    @Published var game: Game?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var gameRepository: GameRepository
    private var favoriteRepository: FavoriteRepository
    
    init(
        gameRepository: GameRepository = GameRemoteDataSource.shared,
        favoriteRepository: FavoriteRepository = GameLocalDataSource.shared
    ) {
        self.gameRepository = gameRepository
        self.favoriteRepository = favoriteRepository
    }
    
    func loadGame(id: Int) {
        game = nil
        isLoading = true
        gameRepository.fetchGame(id: id) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let game):
                self.game = game
                self.getFavorite()
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func getFavorite() {
        guard let game = game else { return }
        
        favoriteRepository.getFavorite(game.id) { [weak self] (isFavorite, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.error = error
            }
            
            DispatchQueue.main.async {
                self.game?.isFavorite = isFavorite
            }
        }
    }
    
    func addFavorite() {
        guard let game = game else { return }
        
        favoriteRepository.addFavorite(game) { [weak self] (isSuccess, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.error = error
            }
            
            DispatchQueue.main.async {
                if isSuccess {
                    self.game?.isFavorite = true
                }
            }
        }
    }
    
    func removeFavorite() {
        guard let game = game else { return }
        
        favoriteRepository.removeFavorite(game.id) { [weak self] (isRemoved, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.error = error
            }
            
            DispatchQueue.main.async {
                if isRemoved {
                    self.game?.isFavorite = false
                }
            }
        }
    }
}
