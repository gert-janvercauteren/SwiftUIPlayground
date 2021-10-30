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
                EmptyView(iconName: "bolt.square.fill",
                          title: "Loading",
                          subtitle: "Hold on tight!",
                          color: .green)
            } else if searchBarObserver.debouncedText.isEmpty {
                EmptyView(iconName: "magnifyingglass.circle.fill",
                          title: "Search movies",
                          subtitle: "Try: Star wars",
                          color: .blue)
            } else if viewModel.movies.isEmpty {
                EmptyView(iconName: "cloud.rain.fill",
                          title: "No results :(",
                          subtitle: "Try: Star wars",
                          color: .orange)
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
                EmptyView(iconName: "heart.circle.fill",
                          title: "No favorites yet",
                          subtitle: "Search your favorite movies and add them to your list",
                          color: .red)
            }
        }
    }
    
    private func tabTitle(_ tab: Tab) -> String {
        switch tab {
        case .search:
            return "Search"
        case .favorites:
            return "Favorites"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
