//
//  Pokemon.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 12/02/23.
//

import Foundation

// MARK: Models

struct Pokemon: Decodable {
    
    let name: String
    
    let url: String
    
    var id: Int {
        
        Int(self.url.split(separator: "/").last?.description ?? "0") ?? 0
        
    }
    
}
