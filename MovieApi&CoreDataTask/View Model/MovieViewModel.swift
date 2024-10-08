import Foundation

class MovieViewModel {
    var movies: [Movie] = []
    let apiKey = "40bfe46"
    lazy var baseUrl = "http://www.omdbapi.com/?apikey=\(apiKey)&"
    var currentPage: Int = 1

    func fetchMovies(title: String, completion: @escaping () -> Void) {
        let searchUrlString = "\(baseUrl)s=\(title)&page=\(currentPage)"
        guard let url = URL(string: searchUrlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                self.movies.append(contentsOf: movieResponse.search)
                completion()
            } catch {
                print("JSON decode error: \(error)")
            }
        }
        task.resume()
    }

    func fetchMoreMovies(title: String, completion: @escaping () -> Void) {
        currentPage += 1
        fetchMovies(title: title, completion: completion)
    }
    func fetchMovieDetails(imdbID: String, completion: @escaping (MovieDetails?) -> Void) {
        let detailsUrlString = "\(baseUrl)i=\(imdbID)"
        guard let url = URL(string: detailsUrlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching movie details: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                completion(movieDetails)
            } catch {
                print("JSON decode error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
