
import Foundation
import UIKit
import SnapKit
class DetailsViewController: UIViewController{
    var imdbID: String!
    var movieViewModel = MovieViewModel()
    var favoriteModel = FavoritesViewModel()
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        return view
    }()
    private let scrollInnerView: UIView = {
        let view = UIView()
        return view
    }()
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        return image
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20,weight: .semibold)
        return label
    }()
    let releaseDate: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12,weight: .semibold)
        return label
    }()
    lazy var posterFisrtLabelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(releaseDate)
        view.spacing = 5
        return view
    }()
    let synopsisLabel: UILabel = {
        let label = UILabel()
        label.text = "SYNOPSIS"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    let synopsisTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.text = "Unknown"
        label.textColor = .black
        return label
    }()
    lazy var synopsisLabelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(synopsisLabel)
        view.addArrangedSubview(synopsisTextLabel)
        view.spacing = 6
        return view
    }()
    let directorLabel: UILabel = {
        let label = UILabel()
        label.text = "DIRECTOR"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    let directorTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.text = "Unknown"
        label.textColor = .black
        return label
    }()
    lazy var directorLabelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(directorLabel)
        view.addArrangedSubview(directorTextLabel)
        view.spacing = 6
        return view
    }()
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "GENRE"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    let genreTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.text = "Unknown"
        label.textColor = .black
        return label
    }()
    lazy var genreLabelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(genreLabel)
        view.addArrangedSubview(genreTextLabel)
        view.spacing = 6
        return view
    }()
    let castLabel: UILabel = {
        let label = UILabel()
        label.text = "CAST"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    let castTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.text = "Unknown"
        label.textColor = .black
        return label
    }()
    lazy var castLabelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(castLabel)
        view.addArrangedSubview(castTextLabel)
        view.spacing = 6
        return view
    }()
    let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "DURATION"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
    }()
    let durationTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.text = "Unknown"
        label.textColor = .black
        return label
    }()
    lazy var durationLabelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.addArrangedSubview(durationLabel)
        view.addArrangedSubview(durationTextLabel)
        view.spacing = 6
        return view
    }()
    let metaScoreRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.text = "Unknown"
        label.textAlignment = .center
        return label
    }()
    let metaScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16,weight: .semibold)
        label.text = "Metascore"
        label.textAlignment = .center
        return label
    }()
    let metaScoreLink: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        label.text = "metacritic.com"
        label.textAlignment = .center
        return label
    }()
    lazy var metaScoreStack: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemYellow
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.2
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 4
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(metaScoreRatingLabel)
        stackView.addArrangedSubview(metaScoreLabel)
        stackView.addArrangedSubview(metaScoreLink)
        return stackView
    }()
    let imdbRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.text = "Unknown"
        label.textAlignment = .center
        return label
    }()
    let imdbLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16,weight: .semibold)
        label.text = "IMDb"
        label.textAlignment = .center
        return label
    }()
    let imdbLink: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        label.text = "m.imdb.com"
        label.textAlignment = .center
        return label
    }()
    lazy var imdbStack: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemYellow
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.2
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 4
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(imdbRatingLabel)
        stackView.addArrangedSubview(imdbLabel)
        stackView.addArrangedSubview(imdbLink)
        return stackView
    }()
    lazy var scoresStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.addArrangedSubview(metaScoreStack)
        view.addArrangedSubview(imdbStack)
        view.distribution = .fillEqually
        view.alignment = .center
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCons()
        fetch()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func convertDurationToTimeFormat(duration: String) -> String {
        let components = duration.split(separator: " ")
        guard let timeString = components.first, let timeInMinutes = Int(timeString) else {
            return "00:00:00"
        }
        let hours = timeInMinutes / 60
        let minutes = timeInMinutes % 60
        let seconds = 0
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    func setup(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(scrollInnerView)
        scrollInnerView.addSubview(imageView)
        scrollInnerView.addSubview(synopsisLabelStack)
        scrollInnerView.addSubview(posterFisrtLabelStack)
        scrollInnerView.addSubview(directorLabelStack)
        scrollInnerView.addSubview(castLabelStack)
        scrollInnerView.addSubview(genreLabelStack)
        scrollInnerView.addSubview(durationLabelStack)
        scrollInnerView.addSubview(scoresStack)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = .systemYellow
    }
    var posterURL: String?
    var imdbIDCore: String?
    func fetch(){
        movieViewModel.fetchMovieDetails(imdbID: imdbID) { [weak self] details in
            guard let self = self else { return }
            guard let details = details else { return }
            if let _ = favoriteModel.fetchEntityByID(id: imdbID) {
                DispatchQueue.main.async {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
                }
            } else {
                DispatchQueue.main.async {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
                }
            }
            DispatchQueue.main.async {
                self.titleLabel.text = details.title
                self.releaseDate.text = details.year
                self.synopsisTextLabel.text = details.plot
                self.directorTextLabel.text = details.director
                self.castTextLabel.text = details.actors
                self.metaScoreRatingLabel.text = details.metascore
                self.imdbRatingLabel.text = details.imdbRating
                self.genreTextLabel.text = details.genre
                self.posterURL = details.poster
                self.imdbIDCore = details.imdbID
                let durationText = details.runtime
                let formattedDuration = self.convertDurationToTimeFormat(duration: durationText)
                self.durationTextLabel.text = formattedDuration
                if let posterURL = URL(string: details.poster) {
                    self.imageView.kf.setImage(with: posterURL)
                }
                
            }
        }
    }
    func setupCons(){
        scrollView.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        scrollInnerView.snp.makeConstraints{make in
            make.width.equalTo(scrollView.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        let screenHeight = UIScreen.main.bounds.height
        let height = screenHeight/4
        imageView.snp.makeConstraints{make in
            make.top.equalTo(scrollInnerView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.width.equalTo(height*27/40)
            make.height.equalTo(height)
        }
        posterFisrtLabelStack.snp.makeConstraints{make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualTo(scrollInnerView.snp.trailing).offset(-10)
        }
        synopsisLabelStack.snp.makeConstraints{make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(scrollInnerView.snp.trailing).offset(-10)
        }
        directorLabelStack.snp.makeConstraints{make in
            make.top.equalTo(synopsisLabelStack.snp.bottom).offset(16)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(scrollInnerView.snp.trailing).offset(-10)
        }
        genreLabelStack.snp.makeConstraints{make in
            make.top.equalTo(directorLabelStack.snp.bottom).offset(16)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(scrollInnerView.snp.trailing).offset(-10)
        }
        castLabelStack.snp.makeConstraints{make in
            make.top.equalTo(genreLabelStack.snp.bottom).offset(16)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(scrollInnerView.snp.trailing).offset(-10)
        }
        durationLabelStack.snp.makeConstraints{make in
            make.top.equalTo(castLabelStack.snp.bottom).offset(16)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(scrollInnerView.snp.trailing).offset(-10)
        }
        scoresStack.snp.makeConstraints { make in
            make.top.equalTo(durationLabelStack.snp.bottom).offset(16)
            make.leading.equalTo(scrollInnerView.snp.leading).offset(10)
            make.trailing.equalTo(scrollInnerView.snp.trailing).offset(-10)
            make.bottom.equalTo(scrollInnerView.snp.bottom)
        }
    }
    @objc func rightButtonTapped() {
        if let movie = favoriteModel.fetchEntityByID(id: imdbID) {
            favoriteModel.removeMovie(movie: movie)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        } else {
            favoriteModel.addMovie(title: titleLabel.text ?? "",
                                   year: releaseDate.text ?? "",
                                   poster: posterURL ?? "",
                                   imdbID: imdbID)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        }
        NotificationCenter.default.post(name: NSNotification.Name("favoriteUpdated"), object: nil)
    }
}
