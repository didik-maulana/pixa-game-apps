//
//  Game.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

struct Game: Decodable, Identifiable {
    let id: Int
    let name: String
    let descriptionRaw: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let reviewsCount: Int?
    let suggestionsCount: Int?
    
    let genres: [Genre]?
    let publishers: [Publisher]?
    let developers: [Developer]?
    let platforms: [Platorm]?
    var isFavorite: Bool?
    
    static private let releasedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    
    var releasedText: String {
        guard let released = self.released, let releasedDate = Utils.dateFormatter.date(from: released) else {
            return "n/a"
        }
        return Game.releasedFormatter.string(from: releasedDate)
    }
    
    var ratingWithStarText: String {
        guard let rating = self.rating, rating != 0 else {
            return "★ -"
        }
        return "★ \(rating)"
    }
    
    var backgroundURL: URL? {
        guard let backgroundImage = self.backgroundImage else {
            return nil
        }
        return URL(string: backgroundImage)
    }
    
    var genreText: String {
        var genreString = ""
        if genres?.isEmpty == false {
            genres?.prefix(3).forEach { genre in
                genreString.append(genre.name)
                if genre != genres?.last {
                    genreString.append(", ")
                }
            }
        }
        return genreString
    }
    
    var reviewsCountText: String {
        guard let reviewsCount = self.reviewsCount else {
            return "-"
        }
        return "\(reviewsCount)"
    }

    var suggestionsCountText: String {
        guard let suggestions = self.suggestionsCount else {
            return "-"
        }
        return "\(suggestions)"
    }
    
    var publisherNames: [String] {
        if publishers?.isEmpty == false {
            return publishers?.map { $0.name } ?? []
        } else {
            return []
        }
    }
    
    var developerNames: [String] {
        if developers?.isEmpty == false {
            return developers?.map { $0.name } ?? []
        } else {
            return []
        }
    }
    
    var platformNames: [String] {
        guard let platforms = platforms else {
            return []
        }
        
        var platformList: [String] = []
        platforms.forEach { platform in
            if !platform.platformName.isEmpty {
                platformList.append(platform.platformName)
            }
        }
        return platformList
    }
}
