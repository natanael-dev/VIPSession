//
//  LocalWorker.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 11/02/23.
//

import Foundation

protocol LocalWorker {
    
    var pokemonFrontImageURLBase: String { get }
    
    var pokemonBackImageURLBase: String { get }
    
}

final class LocalWorkerDefault: LocalWorker {
    
    fileprivate let POKEMON_FRONT_IMAGE = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

    fileprivate let POKEMON_BACK_IMAGE = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/"
   
    var pokemonFrontImageURLBase: String {
        
        POKEMON_FRONT_IMAGE
        
    }
    
    var pokemonBackImageURLBase: String {
        
        POKEMON_BACK_IMAGE
        
    }
        
}
