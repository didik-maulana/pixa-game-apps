//
//  Platform.swift
//  PixaGame
//
//  Created by Didik on 14/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

struct Platorm: Decodable {
    let platform: PlatformItem?
    
    var platformName: String {
        return platform?.name ?? ""
    }
}

struct PlatformItem: Decodable {
    let name: String
}
