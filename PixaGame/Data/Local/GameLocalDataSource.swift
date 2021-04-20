//
//  GameLocalDataSource.swift
//  PixaGame
//
//  Created by Didik on 20/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import CoreData

class GameLocalDataSource: FavoriteRepository {
    
    static let shared = GameLocalDataSource()
    
    private let taskContext = DatabaseProvider.shared.newTaskContext()
    
    func getAllFavorite(completion: @escaping (_ games: [Game]?, _ error: NSError?) -> ()) {
        taskContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: DatabaseProvider.favoriteEntityName)
                let results = try self.taskContext.fetch(fetchRequest)
                var games: [Game] = []
                for result in results {
                    let game = Game(
                        id: result.value(forKey: FavoriteAttribute.id.rawValue) as? Int ?? 0,
                        name: result.value(forKey: FavoriteAttribute.name.rawValue) as? String ?? "",
                        descriptionRaw: nil,
                        released: result.value(forKey: FavoriteAttribute.released.rawValue) as? String,
                        backgroundImage: result.value(forKey: FavoriteAttribute.imageUrl.rawValue) as? String,
                        rating: result.value(forKey: FavoriteAttribute.rating.rawValue) as? Double,
                        reviewsCount: nil,
                        suggestionsCount: nil,
                        genres: nil,
                        publishers: nil,
                        developers: nil,
                        platforms: nil
                    )
                    games.append(game)
                }
                completion(games, nil)
            } catch let error as NSError {
                completion(nil, error)
                print("Could not get all favorite. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getFavorite(_ id: Int, completion: @escaping (_ isFavorite: Bool, _ error: NSError?) -> ()) {
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: DatabaseProvider.favoriteEntityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            
            do {
                if try self.taskContext.fetch(fetchRequest).first != nil {
                    completion(true, nil)
                }
            } catch let error as NSError {
                completion(false, error)
                print("Could not get favorite. \(error), \(error.userInfo)")
            }
        }
    }
    
    func addFavorite(_ game: Game, completion: @escaping (_ isSuccess: Bool, _ error: NSError?) -> ()) {
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: DatabaseProvider.favoriteEntityName, in: taskContext) {
                let gameObject = NSManagedObject(entity: entity, insertInto: taskContext)
                gameObject.setValue(game.id, forKey: FavoriteAttribute.id.rawValue)
                gameObject.setValue(game.name, forKey: FavoriteAttribute.name.rawValue)
                gameObject.setValue(game.backgroundImage, forKey: FavoriteAttribute.imageUrl.rawValue)
                gameObject.setValue(game.rating, forKey: FavoriteAttribute.rating.rawValue)
                gameObject.setValue(game.released, forKey: FavoriteAttribute.released.rawValue)
                
                do {
                    try self.taskContext.save()
                    completion(true, nil)
                } catch let error as NSError {
                    completion(false, error)
                    print("Could not add favorite. \(error)")
                }
            }
        }
    }
    
    func removeFavorite(_ id: Int, completion: @escaping (_ isSuccess: Bool, _ error: NSError?) -> ()) {
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DatabaseProvider.favoriteEntityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            
            do {
                let batchDeleteResult = try self.taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                if batchDeleteResult?.result != nil {
                    completion(true, nil)
                }
            } catch let error as NSError {
                completion(false, error)
            }
        }
    }
}
