//
//  GameResponse.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

struct GameListResponse: Decodable {
    let results: [Game]
}
