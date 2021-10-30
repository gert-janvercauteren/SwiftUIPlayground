import SwiftUI

struct MovieList: View {
    
    var movies: [Movie] = []
    
    var body: some View {
        List(movies) { movie in
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                MovieRow(movie: movie)
            }
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(movies: [
            Movie(name: "Test movie", price: 3.99, genre: "Drama")
        ])
    }
}
