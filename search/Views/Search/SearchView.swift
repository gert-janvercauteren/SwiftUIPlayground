import SwiftUI

struct SearchView: View {
    
    var movies: [MovieModel]
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            MovieList(movies: movies)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @State static var searchText = "Test"
    
    static var previews: some View {
        SearchView(movies: [], searchText: $searchText)
    }
}
