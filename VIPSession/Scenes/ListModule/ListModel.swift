//
//  ListModel.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import Foundation

enum ListModel {
    
    // MARK: Use cases
    
    enum GetPokemons {
        
        struct Request {
            
            let limit: Int
            
        }
        
        struct Response: Decodable {
            
            let results: [Pokemon]
            
        }
        
        struct ResponseError {
            
            let message: String
            
        }
        
        struct ViewModel {
            
            let displayedPokemons: [DisplayedPokemon]
            
            struct DisplayedPokemon {
                
                let name: String
                
                let id: Int
                
                let imageUrl: URL?
                
            }
            
            struct DisplayedError {
             
                let title: String
                
                let message: String
                
            }
            
        }
                
    }
        
}

extension Pokemon {
    
    func mapToDisplayedPokemon() -> ListModel.GetPokemons.ViewModel.DisplayedPokemon {
        
        let idPokemon: Int = Int(self.url.split(separator: "/").last?.description ?? "0") ?? 0
        let imageUrlPokemon: URL? = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idPokemon).png")
        return .init(name: self.name, id: idPokemon, imageUrl: imageUrlPokemon)
        
    }
    
}
