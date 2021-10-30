import SwiftUI
import CoreData

struct MovieDetailView: View {
    var movie: MovieModel
    var isFavorite: Bool = true
        
    @Environment(\.managedObjectContext) private var viewContext
    
    var favoriteRequest: FetchRequest<Movie>
    
    init(movie: MovieModel) {
        self.movie = movie
        self.favoriteRequest = FetchRequest<Movie>(entity: Movie.entity(),
                                                   sortDescriptors: [],
                                                   predicate: NSPredicate(format: "itunes_id == %d", movie.id))
    }
    
    var body: some View {
        VStack {
            MovieRow(movie: movie)
            Text(movie.description ?? "No description available")
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .toolbar {
            Button {
                favoriteRequest.wrappedValue.isEmpty ? addToFavorites() : removeFromFavorites()
            } label: {
                Image(systemName: favoriteRequest.wrappedValue.isEmpty ? "heart" : "heart.fill")
                    .accessibilityLabel("Add to favorites ")
                    .tint(.red)
            }
        }
    }
    
    private func addToFavorites() {
        _ = movie.convertToDBModel(withViewContext: viewContext)

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func removeFromFavorites() {
        withAnimation {
            favoriteRequest.wrappedValue.forEach { viewContext.delete($0) }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieModel.preview)
    }
}
