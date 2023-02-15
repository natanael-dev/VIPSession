//
//  DetailInteractor.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 11/02/23.
//

import Foundation

// MARK: Definition

typealias DetailInteractorDelegate = DetailBusinessLogic

protocol DetailBusinessLogic {

    func interactToFetchURLImages(request: DetailModel.GetPokemonsImages.Request)
    
    func interactToUI(request: DetailModel.UI.Request)

}

protocol DetailDataStore {

    var pokemon: Pokemon? { get set }

}

// MARK: Interactor DataStore Implementation

final class DetailInteractor: DetailDataStore {
    
    deinit { Log.i(self) }
    
    let worker: LocalWorker
        
    var presenter: DetailPresenterDelegate!
    
    var pokemon: Pokemon?
    
    init(withWorker worker: LocalWorker) {
        
        self.worker = worker
        
    }
        
}

// MARK: Business Logic Implementation

extension DetailInteractor: DetailBusinessLogic {
    
    func interactToUI(request: DetailModel.UI.Request) {
        
        presenter.presentUI(response: DetailModel.UI.Response())
        
    }
    
    func interactToFetchURLImages(request: DetailModel.GetPokemonsImages.Request) {
        
        let backURL = worker.pokemonBackImageURLBase
        let frontURL = worker.pokemonFrontImageURLBase
        guard let pokemon = pokemon else {
            let error = DetailModel.UI.Error(message: "Pokemon not Found")
            presenter.presentPokemonImagesError(response: error)
            return
        }
        let response = DetailModel.GetPokemonsImages.Response(idPokemon: pokemon.id, backUrlBase: backURL, frontUrlBase: frontURL)
        presenter.presentPokemonImages(response: response)
        
    }
    
}
