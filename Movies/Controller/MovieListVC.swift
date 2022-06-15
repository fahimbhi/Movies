//
//  MovieListVC.swift
//  Movies
//
//  Created by Faheem Rahman on 15/06/22.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet weak var moviesCollection : UICollectionView!
    
    private lazy var searchController: UISearchController = {
        let searchCntrl = UISearchController(searchResultsController: nil)
        searchCntrl.searchResultsUpdater = self
        searchCntrl.delegate = self
        searchCntrl.obscuresBackgroundDuringPresentation = false
        searchCntrl.searchBar.placeholder = "Enter A Film Name"
        searchCntrl.searchBar.autocapitalizationType = .allCharacters
        return searchCntrl
    }()
    
    private var moviewListVM = MovieListVM()
    var movieList : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerCell()
        getAllMovies(searchText: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setUpView() {
        self.title = "Film list"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    func registerCell() {
        moviesCollection.register(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionCell")
    }
}

// MARK: - Service Requests
extension MovieListVC {
    func getAllMovies(searchText : String?){
        moviewListVM.completionHandler { [weak self] (response) in
            guard let self = self else {return}
            self.movieList = response
            DispatchQueue.main.async {
                self.moviesCollection.reloadData()
            }
        }
        moviewListVM.getAllMovies(search: searchText)
    }
}

// MARK: - SearchControll Delegate
extension MovieListVC : UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        getAllMovies(searchText: searchController.searchBar.text!)
    }
}

// MARK: - Collection view data source
extension MovieListVC : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.search?.count ?? 0
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = moviesCollection.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.movieItem = movieList?.search?[indexPath.row]
            return cell
        }
}
