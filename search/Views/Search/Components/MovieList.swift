import SwiftUI

struct MovieList: View {
    
    var movies: [MovieModel] = []
    
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
            MovieModel(title: "Test movie", price: 3.99, genre: "Drama")
        ])
    }
}
