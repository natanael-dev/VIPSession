//
//  DetailRouter.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 11/02/23.
//

import Foundation

// MARK: Definition

typealias DetailRouterDelegate = DetailRoutingLogic & DetailDataPassing

protocol DetailRoutingLogic {
    
    var viewController: DetailViewController? { get set }
    
}

// MARK: Data passing

protocol DetailDataPassing {
    
    var datastore: DetailDataStore? { get }
    
}

// MARK: Router Implementation

final class DetailRouter: DetailDataPassing, DetailRoutingLogic {
    
    deinit { Log.i(self) }
    
    weak var viewController: DetailViewController?
    
    var datastore: DetailDataStore?
    
}
