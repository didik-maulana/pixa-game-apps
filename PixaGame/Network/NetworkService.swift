//
//  NetworkService.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case emptyData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .emptyData:
            return "Empty data"
        case .serializationError:
            return "Failed to decode data"
        }
    }
}

class NetworkService {    
    static let shared = NetworkService()
    
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func loadURLAndDecode<D: Decodable>(
        url: URL,
        params: [String: String]? = nil,
        completion: @escaping (Result<D, NetworkError>) -> ()
    ) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems: [URLQueryItem] = []
        if let params = params {
            queryItems.append(contentsOf: params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            })
            urlComponents.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeNetworkCallback(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeNetworkCallback(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeNetworkCallback(with: .failure(.emptyData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeNetworkCallback(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeNetworkCallback(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    func executeNetworkCallback<D: Decodable>(
        with result: Result<D, NetworkError>,
        completion: @escaping (Result<D, NetworkError>) -> ()
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
