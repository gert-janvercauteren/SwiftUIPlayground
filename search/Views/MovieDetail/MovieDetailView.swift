import SwiftUI
import CoreData

struct MovieDetailView: View {
    var movie: MovieModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
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
                addToFavorites()
            } label: {
                Image(systemName: "heart")
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
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieModel(title: "Test", price: 3.00, genre: "Test"))
    }
}
