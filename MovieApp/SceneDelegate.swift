//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by endava on 08.04.2024..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
                
        let navigationController1 = UINavigationController()
        let router1 = Router(navigationController: navigationController1)
        let movieCategoriesVC = MovieCategoriesViewController(router: router1)
        navigationController1.navigationBar.tintColor = .black
        movieCategoriesVC.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "house"), selectedImage: nil)
        navigationController1.viewControllers = [movieCategoriesVC]
    
        let navigationController2 = UINavigationController()
        let router2 = Router(navigationController: navigationController2)
        let favoritesVC = FavoritesViewController(router: router2)
        navigationController2.navigationBar.tintColor = .black
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: nil)
        navigationController2.viewControllers = [favoritesVC]
                
        tabBarController.viewControllers = [navigationController1, navigationController2]
        
        window = UIWindow(windowScene: windowsScene)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

