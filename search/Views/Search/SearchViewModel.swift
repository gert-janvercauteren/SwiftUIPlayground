import Foundation
import Combine

enum Tab {
  case search, favorites
}

class SearchViewModel: ObservableObject {
    @Published var currentTab: Tab = .search
    @Published var movies: [MovieModel] = []
    @Published var isLoading: Bool = false
    
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
        self.isLoading = true
        cancellationToken = ItunesAPI.request(.getMovies(query: searchTerm))
            .mapError({ (error) -> Error in
                self.isLoading = false
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.isLoading = false
                    self.movies = $0.movies
            })
    }
}
