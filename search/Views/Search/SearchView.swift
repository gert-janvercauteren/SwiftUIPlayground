import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            MovieList(movies: viewModel.movies)
        }
        .onChange(of: searchText) { value in
            viewModel.getMovies(searchTerm: value)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
