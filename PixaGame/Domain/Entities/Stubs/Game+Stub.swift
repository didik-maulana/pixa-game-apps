//
//  Game+Stub.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

extension Game {
    static var stubbedGames: [Game] {
        let response: GameListResponse? = Bundle.main.loadAndDecodeJSON(filename: "game_list")
        return response?.results ?? []
    }
    
    static var stubbedGame: Game {
        return stubbedGames[0]
    }
    
    static var stubbedGameDetail: Game {
        let game: Game = Bundle.main.loadAndDecodeJSON(filename: "game_detail") ?? stubbedGame
        return game
    }
}
