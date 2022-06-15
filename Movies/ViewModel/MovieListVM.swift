//
//  MovieListVM.swift
//  Movies
//
//  Created by Faheem Rahman on 15/06/22.
//

import Foundation

class MovieListVM : NSObject {
    
    typealias vmCallBack = (_ response: Movie?) -> Void
    var callback: vmCallBack?
    private var apiService : Router!
    private(set) var movieData : Movie! {
        didSet {
            self.callback?(movieData)
        }
    }
    
    override init() {
        super.init()
        self.apiService =  Router()
    }
    
    func getAllMovies(search : String?) {
        self.apiService.getAllMovies_API(searchKey: search){ [weak self] (movieData) in
            guard let self = self else {return}
            self.movieData = movieData
        }
    }
    
    //MARK:- Completion Handler
    func completionHandler(callBackObj: @escaping vmCallBack) {
        self.callback = callBackObj
    }
}

