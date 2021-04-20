//
//  GameRemoteDataSource.swift
//  PixaGame
//
//  Created by Didik on 08/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

class GameRemoteDataSource: GameRepository {
    
    static let shared = GameRemoteDataSource()
    
    private let baseAPIURL = "https://api.rawg.io/api"
    private let service = NetworkService.shared
    
    func fetchGames(page: Int, completion: @escaping (Result<GameListResponse, NetworkError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/games") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let params: [String: String] = [
            "page": "\(page)",
            "key": "624087f7be5541aea32549024d9a000f"
        ]
        
        service.loadURLAndDecode(url: url, params: params, completion: completion)
    }
    
    func fetchGame(id: Int, completion: @escaping (Result<Game, NetworkError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/games/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        let params: [String: String] = [
            "key": "624087f7be5541aea32549024d9a000f"
        ]
        service.loadURLAndDecode(url: url, params: params, completion: completion)
    }
    
    func searchGame(query: String, completion: @escaping (Result<GameListResponse, NetworkError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/games") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let params: [String: String] = [
            "search": query,
            "key": "624087f7be5541aea32549024d9a000f"
        ]
        service.loadURLAndDecode(url: url, params: params, completion: completion)
    }
}
