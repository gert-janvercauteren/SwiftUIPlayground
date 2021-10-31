import SwiftUI
import CoreData

struct MovieDetailView: View {
    var movie: MovieModel
    var isFavorite: Bool = true
    var favoriteRequest: FetchRequest<Movie>
    
    @State private var showingAlert = false
    @Environment(\.managedObjectContext) private var viewContext
    
    init(movie: MovieModel) {
        self.movie = movie
        self.favoriteRequest = FetchRequest<Movie>(entity: Movie.entity(),
                                                   sortDescriptors: [],
                                                   predicate: NSPredicate(format: "itunes_id == %d", movie.id))
    }
    
    var body: some View {
        VStack {
            MovieRow(movie: movie)
            ScrollView {
                Text(movie.description ?? "No description available")
            }
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
                    .accessibilityLabel(favoriteRequest.wrappedValue.isEmpty ? "Add to favorites " : "Remove from favorites")
                    .tint(.red)
            }
        }
        .alert("Could not add/remove as favorite", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func addToFavorites() {
        _ = movie.convertToDBModel(withViewContext: viewContext)

        do {
            try viewContext.save()
        } catch {
            // Should handle error. Not interested for demo
            showingAlert = true
        }
    }
    
    private func removeFromFavorites() {
        withAnimation {
            favoriteRequest.wrappedValue.forEach { viewContext.delete($0) }

            do {
                try viewContext.save()
            } catch {
                // Should handle error. Not interested for demo
                showingAlert = true
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieModel.preview)
    }
}
