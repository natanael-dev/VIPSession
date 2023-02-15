//
//  DetailViewController.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 11/02/23.
//

import UIKit

// MARK: Definition

typealias DetailViewDelegate = DetailDisplayLogic

protocol DetailDisplayLogic: AnyObject {
   
    func displayPokemonImages(viewModel: DetailModel.GetPokemonsImages.ViewModel)
    
    func displayNotFoundImages()
    
    func displayUI(displayedInfo: DetailModel.UI.ViewModel.DisplayedUI)

}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonFrontImage: UIImageView!
    
    @IBOutlet weak var pokemonBackImage: UIImageView!
    
    deinit { Log.i(self) }
    
    var interactor: DetailInteractorDelegate!
    
    var router: DetailRouterDelegate!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
      super.init(coder: aDecoder)
      setup()
        
    }
    
    // MARK: Setup
    
    private func setup() {
        
      let viewController = self
      let interactor = DetailInteractor(withWorker: LocalWorkerDefault())
      let presenter = DetailPresenter()
      let router = DetailRouter()
      viewController.interactor = interactor
      viewController.router = router
      interactor.presenter = presenter
      presenter.view = viewController
      router.viewController = viewController
      router.datastore = interactor
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        interactor.interactToUI(request: DetailModel.UI.Request())
        interactor.interactToFetchURLImages(request: DetailModel.GetPokemonsImages.Request())        
        
    }

}

// MARK: Display Logic Implementation

extension DetailViewController: DetailViewDelegate {
    
    func displayPokemonImages(viewModel: DetailModel.GetPokemonsImages.ViewModel) {
        
        pokemonFrontImage.af.setImage(withURL: viewModel.displayedPokemon.frontImageURL)
        pokemonBackImage.af.setImage(withURL: viewModel.displayedPokemon.backImageURL)
        
    }
    
    func displayNotFoundImages() {
        
        pokemonFrontImage.image = UIImage(systemName: "photo.on.rectangle.angled")
        pokemonBackImage.image = UIImage(systemName: "photo.on.rectangle.angled")
        
    }
    
    func displayUI(displayedInfo: DetailModel.UI.ViewModel.DisplayedUI) {
        
        self.title = displayedInfo.title
        
    }
    
}
