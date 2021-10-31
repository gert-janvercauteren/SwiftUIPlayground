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
            MovieModel.preview,
            MovieModel.preview,
            MovieModel.preview
        ])
    }
}
