//
//  GameRepository.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

protocol GameRepository {
    func fetchGames(page: Int, completion: @escaping (Result<GameListResponse, NetworkError>) -> ())
    func fetchGame(id: Int, completion: @escaping (Result<Game, NetworkError>) -> ())
    func searchGame(query: String, completion: @escaping (Result<GameListResponse, NetworkError>) -> ())
}
