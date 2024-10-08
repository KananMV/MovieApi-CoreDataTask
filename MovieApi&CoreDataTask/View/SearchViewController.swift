import UIKit
import SnapKit
class SearchViewController: UIViewController {
    let customSearch = SearchCustomView()
    let viewModel = MovieViewModel()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    @objc func loadMoreMovies() {
        guard let title = customSearch.textField.text, !title.isEmpty else { return }
        viewModel.fetchMoreMovies(title: title) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCons()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setup(){
        customSearch.textField.delegate = self
        view.backgroundColor = .white
        view.addSubview(customSearch)
        view.addSubview(collectionView)
        let backButton = UIBarButtonItem()
        backButton.title = "Search"
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    func setupCons(){
        customSearch.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints{make in
            make.top.equalTo(customSearch.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let title = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
            return true
        }
        viewModel.currentPage = 1
        viewModel.movies.removeAll()
        viewModel.fetchMovies(title: title) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        textField.resignFirstResponder()
        return true
    }
}
extension SearchViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY >= contentHeight - height - 100 {
            let title = customSearch.textField.text ?? ""
            viewModel.fetchMoreMovies(title: title) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let totalWidth = collectionView.frame.width - padding
        let itemWidth = totalWidth / 2
        return CGSize(width: itemWidth, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.item]
            let detailsVC = DetailsViewController()
            detailsVC.imdbID = selectedMovie.imdbID
            navigationController?.pushViewController(detailsVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}


