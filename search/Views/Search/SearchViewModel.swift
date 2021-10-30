import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    var searchText = "" {
        didSet {
            getMovies(searchTerm: searchText)
        }
    }
    var cancellationToken: AnyCancellable?
    
    init() {
        getMovies(searchTerm: searchText)
    }
}

extension SearchViewModel {
    func getMovies(searchTerm: String) {
        cancellationToken = ItunesAPI.request(.getMovies(query: searchTerm))
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.movies = $0.movies
            })
    }
}
