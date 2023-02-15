//
//  ListViewController.swift
//  VIPSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/02/23.
//

import UIKit

// MARK: Definition

typealias ListViewDelegate = ListDisplayLogic

protocol ListDisplayLogic: AnyObject {
   
    func displayFetchedPokemons(viewModel: ListModel.GetPokemons.ViewModel)
    
    func displayError(displayedError: ListModel.GetPokemons.ViewModel.DisplayedError)

}

// MARK: View Implementation

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView! {
        
        didSet {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.rowHeight = 116
            listTableView.separatorStyle = .none
            listTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonId")
        }
        
    }
    
    deinit { Log.i(self) }
    
    var interactor: ListInteractorDelegate!
    
    var router: ListRouterDelegate!
    
    fileprivate var listItems: [ListModel.GetPokemons.ViewModel.DisplayedPokemon] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        let request = ListModel.GetPokemons.Request(limit: 180)
        interactor.fetchPokemon(request: request)

    }
    
    public init(){
        
        super.init(nibName: String(describing: ListViewController.self), bundle: Bundle(for: ListViewController.self))
        self.configure()
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.configure()
    
    }
    
    func configure(){
        
        let viewController = self
        let presenter = ListPresenter()
        let worker = NetworkWorkerDefault()
        let interactor = ListInteractor(withWorker: worker)
        let router = ListRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        viewController.router = router
        router.viewController = viewController
        router.datastore = interactor
        
    }
    
}

// MARK: Display Logic Implementation

extension ListViewController: ListDisplayLogic {
      
    func displayFetchedPokemons(viewModel: ListModel.GetPokemons.ViewModel) {
        
        self.listItems = viewModel.displayedPokemons
        DispatchQueue.main.async { [weak self] in
            self?.listTableView.reloadData()
        }
        
    }
    
    func displayError(displayedError: ListModel.GetPokemons.ViewModel.DisplayedError) {
        
        let alert = UIAlertController(title: displayedError.title, message: displayedError.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

// MARK: UITableViewDelegate & UITableViewDataSource Implementation

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       listItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonId", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        let pokemonItem = self.listItems[indexPath.row]
        cell.nameLabel.text = pokemonItem.name
        cell.numberLabel.text = pokemonItem.id.description
        cell.previewImage.image = nil
        if let url = pokemonItem.imageUrl {
            cell.previewImage.af.setImage(withURL: url)
        } else {
            cell.previewImage?.image = nil
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        router.routeToDetail(of: indexPath.row)
        
    }

}
