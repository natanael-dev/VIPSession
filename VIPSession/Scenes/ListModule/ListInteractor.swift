//
//  ListInteractor.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import Foundation

// MARK: Definition

typealias ListInteractorDelegate = ListBusinessLogic

protocol ListBusinessLogic {

    func fetchPokemon(request: ListModel.GetPokemons.Request)

}

protocol ListDataStore {

    var getPokemonsResponse: ListModel.GetPokemons.Response? { get set }

}

// MARK: Interactor DataStore Implementation

final class ListInteractor: ListDataStore {
    
    deinit { Log.i(self) }
    
    let worker: NetworkWorker
    
    var getPokemonsResponse: ListModel.GetPokemons.Response?
    
    var presenter: ListPresenterDelegate!
    
    init(withWorker worker: NetworkWorker) {
        
        self.worker = worker
        
    }
        
}

// MARK: Business Logic Implementation

extension ListInteractor: ListBusinessLogic {
    
    func fetchPokemon(request: ListModel.GetPokemons.Request) {
        
        worker.fetchPokemonInformation(request: request, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.getPokemonsResponse = response
                self.presenter.presentGetPokemons(response: response)
            case .failure(let error):
                let errorResponse = ListModel.GetPokemons.ResponseError(message: error.localizedDescription)
                self.presenter.presentGetPokemonsError(error: errorResponse)
            }
        } )
        
    }
    
}
