import Foundation
import CoreData

class FavoritesViewModel {
    
    private let context = CoreDataModel.shared.persistentContainer.viewContext
    func fetchFavoriteMovies(completion: @escaping ([ListEntity]) -> Void) {
        let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
        
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            completion(favoriteMovies)
        } catch {
            print("Error fetching favorite movies: \(error)")
            completion([])
        }
    }
    
    func fetchEntityByID(id: String) -> ListEntity? {
        let fetchRequest: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", id as CVarArg)
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects.first
        } catch {
            return nil
        }
    }
    
    func addMovie(title: String, year: String, poster: String,imdbID: String) {
        let newMovie = ListEntity(context: context)
        newMovie.title = title
        newMovie.year = year
        newMovie.poster = poster
        newMovie.imdbID = imdbID
        CoreDataModel.shared.saveContext()
    }
    func removeMovie(movie: ListEntity) {
        context.delete(movie)
        CoreDataModel.shared.saveContext()
    }
}
