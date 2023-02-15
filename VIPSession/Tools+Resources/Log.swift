//
//  Log.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import Foundation

struct Log {
    
    static func i<Subject>(_ instance: Subject) {
        
        print("deinit--> \(String(describing: instance))")
        
    }
    
}
