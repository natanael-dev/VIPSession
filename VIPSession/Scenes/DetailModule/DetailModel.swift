//
//  DetailModel.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 11/02/23.
//

import Foundation

enum DetailModel {
    
    // MARK: Use cases
    
    enum UI {
        
        struct Request {
        
        }
        
        struct Response {
        
        }
        
        struct Error {
            
            let message: String
            
        }
        
        struct ViewModel {
            
            let displayedUI: DisplayedUI
            
            struct DisplayedUI {
                
                let title: String
                
            }                        
            
        }
        
    }
    
    enum GetPokemonsImages {
        
        struct Request {
       
        }
        
        struct Response {
            
            let idPokemon: Int
            
            let backUrlBase: String
            
            let frontUrlBase: String
            
        }
        
        struct ResponseError {
            
            let message: String
            
        }
        
        struct ViewModel {
            
            let displayedPokemon: DisplayedPokemon
            
            struct DisplayedPokemon {
                
                let backImageURL: URL
                
                let frontImageURL: URL
                
            }
            
            struct DisplayedError {
                
                let message: String
                
            }
            
        }
                
    }
        
}
