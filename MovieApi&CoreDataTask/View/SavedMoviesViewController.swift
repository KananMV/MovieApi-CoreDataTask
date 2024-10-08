import UIKit
import SnapKit

class SavedMoviesViewController: UIViewController {
    private var favoriteMovies: [ListEntity] = []
    private let viewModel = FavoritesViewModel()
    private lazy var detailsVC = DetailsViewController()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCons()
        fetchFavorites()
    }
    @objc func handleFavoriteUpdate() {
        fetchFavorites()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Favorites"
    }
    func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteUpdate), name: NSNotification.Name("favoriteUpdated"), object: nil)
    }

    private func fetchFavorites() {
        viewModel.fetchFavoriteMovies { [weak self] movies in
            self?.favoriteMovies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    func setupCons() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension SavedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let movie = favoriteMovies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.selectionStyle = .none
        cell.yearLabel.text = movie.year
        if let posterURL = movie.poster, let url = URL(string: posterURL) {
            cell.posterImageView.kf.setImage(with: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = favoriteMovies[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.imdbID = selectedMovie.imdbID
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
