//
//  ListPresenter.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import Foundation

// MARK: Definition

typealias ListPresenterDelegate = ListPresentationLogic

protocol ListPresentationLogic {

    func presentGetPokemons(response: ListModel.GetPokemons.Response)
    
    func presentGetPokemonsError(error: ListModel.GetPokemons.ResponseError)
    
}

// MARK: Presenter Implementation

final class ListPresenter  {
    
    deinit { Log.i(self) }

    unowned var view: ListViewDelegate!
    
}

// MARK: Presentation Logic Implementation

extension ListPresenter: ListPresentationLogic {
    
    func presentGetPokemons(response: ListModel.GetPokemons.Response) {
        
        let displayedPokemon = response.results.map{ $0.mapToDisplayedPokemon() }
        let viewModel = ListModel.GetPokemons.ViewModel(displayedPokemons: displayedPokemon)
        self.view.displayFetchedPokemons(viewModel: viewModel)
        
    }
    
    func presentGetPokemonsError(error: ListModel.GetPokemons.ResponseError) {
        
        let displayedError = ListModel.GetPokemons.ViewModel.DisplayedError(title: "Lo sentimos", message: "Error: \(error.message)")
        view.displayError(displayedError: displayedError)
        
    }

}
