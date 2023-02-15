//
//  NetworkWorker.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import Foundation
import Alamofire
import AlamofireImage

protocol NetworkWorker {
    
    func fetchPokemonInformation(request: ListModel.GetPokemons.Request, completion: @escaping (Result<ListModel.GetPokemons.Response, Error>) -> ())
    
}

final class NetworkWorkerDefault: NetworkWorker {
    
    func fetchPokemonInformation(request: ListModel.GetPokemons.Request, completion: @escaping (Result<ListModel.GetPokemons.Response, Error>) -> ())  {
        
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=\(request.limit)").responseDecodable(of: ListModel.GetPokemons.Response.self) { response in
            switch response.result {
            case .success(let pokemons):
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
