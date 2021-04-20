//
//  GameSearchState.swift
//  PixaGame
//
//  Created by Didik on 08/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class GameSearchState: ObservableObject {
    
    @Published var query = ""
    @Published var games: [Game]?
    @Published var isLoading = false
    @Published var isEmptySearch = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    private var repository: GameRepository
    
    init(repository: GameRepository = GameRemoteDataSource.shared) {
        self.repository = repository
    }
    
    deinit {
        subscriptionToken?.cancel()
        subscriptionToken = nil
    }
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        subscriptionToken = self.$query.map { [weak self] text in
            self?.games = nil
            self?.error = nil
            self?.isEmptySearch = false
            return text
        }
        .throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
        .sink { [weak self] in
            self?.searchGame(query: $0)
        }
    }
    
    func searchGame(query: String) {
        games = nil
        error = nil
        isLoading = false
        isEmptySearch = false
        
        guard !query.isEmpty else { return }
        
        isLoading = true
        repository.searchGame(query: query) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.games = response.results
                self.isEmptySearch = response.results.isEmpty
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
