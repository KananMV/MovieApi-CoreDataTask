import Foundation
import Alamofire

class MovieViewModel {
    var movies: [Movie] = []
    let apiKey = "40bfe46"
    lazy var baseUrl = "http://www.omdbapi.com/?apikey=\(apiKey)&"
    var currentPage: Int = 1
    func fetchMovies(title: String, completion: @escaping () -> Void) {
        AF.request("\(baseUrl)s=\(title)&page=\(currentPage)")
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                if let movieResponse = try? response.result.get() {
                    self.movies.append(contentsOf: movieResponse.search)
                    completion()
                }
            }
    }
    
    func fetchMoreMovies(title: String, completion: @escaping () -> Void) {
        currentPage += 1
        fetchMovies(title: title, completion: completion)
    }
    
    func fetchMovieDetails(imdbID: String, completion: @escaping (MovieDetails?) -> Void) {
        let detailsUrlString = "\(baseUrl)i=\(imdbID)"
        AF.request(detailsUrlString)
            .validate()
            .responseDecodable(of: MovieDetails.self) { response in
                if let movieDetails = try? response.result.get() {
                    completion(movieDetails)
                } else {
                    completion(nil)
                }
            }
    }
}
