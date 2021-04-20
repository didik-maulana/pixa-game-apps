//
//  FavoriteRepository.swift
//  PixaGame
//
//  Created by Didik on 20/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

protocol FavoriteRepository {
    func getAllFavorite(completion: @escaping (_ games: [Game]?, _ error: NSError?) -> ())
    func getFavorite(_ id: Int, completion: @escaping (_ isFavorite: Bool, _ error: NSError?) -> ())
    func addFavorite(_ game: Game, completion: @escaping (_ isSuccess: Bool, _ error: NSError?) -> ())
    func removeFavorite(_ id: Int, completion: @escaping (_ isSuccess: Bool, _ error: NSError?) -> ())
}
