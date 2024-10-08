import UIKit
import SnapKit
class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTabBarAppearance()
    }
    func setup(){
        let searchViewController = SearchViewController()
        let searchImage = UIImage(systemName: "magnifyingglass.circle")
        let selectedSearchImage = UIImage(systemName: "magnifyingglass.circle.fill")
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: searchImage, selectedImage: selectedSearchImage)

        let favoritesImage = UIImage(systemName: "star")
        let selectedFavoritesImage = UIImage(systemName: "star.fill")
        let savedMoviesViewController = SavedMoviesViewController()
        savedMoviesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: favoritesImage, selectedImage: selectedFavoritesImage)

        let searchNavController = UINavigationController(rootViewController: searchViewController)
        let favoritesNavController = UINavigationController(rootViewController: savedMoviesViewController)

        viewControllers = [searchNavController, favoritesNavController]

        tabBar.backgroundColor = .black
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = .lightGray
    }
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
