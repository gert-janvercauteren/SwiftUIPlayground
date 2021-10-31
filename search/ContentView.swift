import SwiftUI
import CoreData

struct ContentView: View {
    enum Tab {
      case search, favorites
    }
    
    @StateObject var searchBarObserver = SearchBarObserver()
    @ObservedObject var viewModel = SearchViewModel()
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var favorites: FetchedResults<Movie>
    
    @State private var currentTab: Tab = .search
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                // Search tab
                VStack {
                    SearchBar(text: $searchBarObserver.searchText)
                    Spacer()
                    searchView()
                    Spacer()
                }
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
                .tag(Tab.search)
                
                // Favorites tab
               favoritesView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Favorites")
                }
                .tag(Tab.favorites)
            }
            .onChange(of: searchBarObserver.debouncedText) { value in
                viewModel.getMovies(searchTerm: value)
            }
            .navigationTitle(tabTitle(currentTab))
        }
    }
    
    private func searchView() -> some View {
        Group {
            if viewModel.isLoading {
                EmptyView.loadingMovies
            } else if searchBarObserver.debouncedText.isEmpty {
                EmptyView.emptyMovies
            } else if viewModel.movies.isEmpty {
                EmptyView.noResultsMovies
            } else {
                MovieList(movies: viewModel.movies)
            }
        }
    }
    
    private func favoritesView() -> some View {
        Group {
            if !favorites.isEmpty {
                MovieList(movies: favorites.map {
                    MovieModel(withDbModel: $0)
                })
            } else {
                EmptyView.emptyFavorites
            }
        }
    }
    
    private func tabTitle(_ tab: Tab) -> LocalizedStringKey {
        switch tab {
        case .search:
            return "search.title"
        case .favorites:
            return "favorites.title"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
