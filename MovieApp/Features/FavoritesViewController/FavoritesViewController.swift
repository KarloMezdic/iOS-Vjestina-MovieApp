//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by endava on 18.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class FavoritesViewController : UIViewController {
    
    private let router : Router!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    init(router: Router!){
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
