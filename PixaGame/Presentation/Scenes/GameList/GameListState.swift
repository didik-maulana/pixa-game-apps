//
//  GameListState.swift
//  PixaGame
//
//  Created by Didik on 08/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

class GameListState: ObservableObject {
    
    @Published var games: [Game]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var repository: GameRepository
    
    init(repository: GameRepository = GameRemoteDataSource.shared) {
        self.repository = repository
    }
    
    func loadGames(page: Int = 1) {
        games = nil
        isLoading = true
        repository.fetchGames(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.games = response.results
            case.failure(let error):
                self.error = error as NSError
            }
        }
    }
}
