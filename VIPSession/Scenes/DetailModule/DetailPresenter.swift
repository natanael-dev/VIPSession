//
//  DetailPresenter.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 11/02/23.
//

import Foundation
import UIKit

// MARK: Definition

typealias DetailPresenterDelegate = DetailPresentationLogic

protocol DetailPresentationLogic {
    
    func presentPokemonImages(response: DetailModel.GetPokemonsImages.Response)
    
    func presentPokemonImagesError(response: DetailModel.UI.Error)
    
    func presentUI(response: DetailModel.UI.Response)
    
}

// MARK: Presenter Implementation

final class DetailPresenter  {
    
    deinit { Log.i(self) }
    
    unowned var view: DetailViewDelegate!
    
}

// MARK: Presentation Logic Implementation

extension DetailPresenter: DetailPresentationLogic {
    
    func presentPokemonImages(response: DetailModel.GetPokemonsImages.Response) {
        
        if
            let frontURL = URL(string: "\(response.frontUrlBase)\(response.idPokemon).png"),
            let backURL = URL(string: "\(response.backUrlBase)\(response.idPokemon).png") {
            let displayPokemon = DetailModel.GetPokemonsImages.ViewModel.DisplayedPokemon(backImageURL: backURL, frontImageURL: frontURL)
            let viewModel = DetailModel.GetPokemonsImages.ViewModel(displayedPokemon: displayPokemon)
            view.displayPokemonImages(viewModel: viewModel)
        } else {
            view.displayNotFoundImages()
        }
        
    }
    
    func presentPokemonImagesError(response: DetailModel.UI.Error) {
        
        view.displayNotFoundImages()
        
    }
    
    func presentUI(response: DetailModel.UI.Response) {
        
        view.displayUI(displayedInfo: DetailModel.UI.ViewModel.DisplayedUI(title: ""))
        
    }
}
