//
//  ListRouter.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import Foundation

// MARK: Definition

typealias ListRouterDelegate = ListRoutingLogic & ListDataPassing

protocol ListRoutingLogic {
    
    var viewController: ListViewController? { get set }
    
    func routeToDetail(of rowTable: Int)
    
}

// MARK: Data passing

protocol ListDataPassing {
    
    var datastore: ListDataStore? { get }
    
}

// MARK: Router Implementation

final class ListRouter: ListDataPassing, ListRoutingLogic {
    
    deinit { Log.i(self) }
    
    weak var viewController: ListViewController?
    
    var datastore: ListDataStore?
    
    func routeToDetail(of rowTable: Int) { // Rename this
        
        let destinationVC = DetailViewController()
        var destinationDS = destinationVC.router?.datastore
        passDataToDetail(row: rowTable, source: datastore, destination: &destinationDS)
        navigateToDetail(source: viewController, destination: destinationVC)
        
    }
    
    // MARK: Navigation
    
    func navigateToDetail(source: ListViewController?, destination: DetailViewController) {
        
        source?.navigationController?.pushViewController(destination, animated: true)
        
    }
    
    // MARK: Passing data
    
    func passDataToDetail(row: Int, source: ListDataStore?, destination: inout DetailDataStore?) {
        
        destination?.pokemon = source?.getPokemonsResponse?.results[row]
        
    }
    
}
