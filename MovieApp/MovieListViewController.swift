

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieListViewController : UIViewController{
    
    private var collectionViewFirst : UICollectionView!
    
    private let movieUseCase = MovieUseCase()
    
    private var router : Router!
    
    
    init(router: Router!){
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        view.backgroundColor = .white
        
        buildView()
        defineLayout()
        
    }
    
    func buildView(){
        
        let layoutType = UICollectionViewFlowLayout()
        layoutType.scrollDirection = .vertical
        
        collectionViewFirst = UICollectionView(frame: .zero, collectionViewLayout: layoutType)
        
        collectionViewFirst.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionViewFirst.alwaysBounceVertical = true
        view.addSubview(collectionViewFirst)
        collectionViewFirst.translatesAutoresizingMaskIntoConstraints = false
        collectionViewFirst.dataSource = self
        collectionViewFirst.delegate = self
    }
    
    func defineLayout(){
        
        collectionViewFirst.autoPinEdge(toSuperviewEdge: .top)
        collectionViewFirst.autoPinEdge(toSuperviewEdge: .bottom)
        collectionViewFirst.autoPinEdge(toSuperviewEdge: .leading)
        collectionViewFirst.autoPinEdge(toSuperviewEdge: .trailing)
        
        view.addSubview(collectionViewFirst)
        
    }
}

extension MovieListViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieUseCase.allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionViewFirst.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell else{
            fatalError("Err")
        }
        
        let moviedetails = movieUseCase.allMovies[indexPath.item]
        
        cell.name.text = moviedetails.name
        cell.summary.text = moviedetails.summary
        
        let imageUrl = URL(string: moviedetails.imageUrl)!
         
        cell.img.load(url: imageUrl)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgTap(_:)))
        cell.img.isUserInteractionEnabled = true
        cell.img.addGestureRecognizer(tapGesture)
        cell.img.tag = moviedetails.id
        
        return cell
    }
    
    @objc func imgTap(_ sender: UITapGestureRecognizer){
        guard let imageView = sender.view as? UIImageView else { return }
        let movId = imageView.tag
        router.showMovieDetails(id: movId)
    }
}

extension MovieListViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let ladscape = UIDevice.current.orientation.isLandscape
        let width = ladscape ? max(screenWidth, screenHeight)-125 : screenWidth
        
        let height: CGFloat = 220
        
        
        return CGSize(width: width, height: height)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
