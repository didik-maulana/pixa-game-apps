//
//  Bundle+Ext.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) -> D? {
        var result: D?
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        if let data = try? Data(contentsOf: url) {
            let jsondecoder = Utils.jsonDecoder
            do {
                result = try jsondecoder.decode(D.self, from: data)
            } catch {
                print("error trying parse json")
            }
        }
        return result
    }
}
