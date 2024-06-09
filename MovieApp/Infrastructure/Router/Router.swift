//
//  Router.swift
//  MovieApp
//
//  Created by endava on 18.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class Router {
    
    private let navigationController : UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    
    func showMovieDetails(id: Int){
        let viewController = MovieDetailsViewController(router: self, id: id)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showMovieList(){
        let viewController = MovieListViewController(router: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    func showMovieCategories(){
        let viewController = MovieCategoriesViewController(router: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
