import SwiftUI
import CoreData

struct ContentView: View {
    enum Tab {
      case search, favorites
    }
    
    @State var searchText = ""
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
                SearchView(movies: viewModel.movies, searchText: $searchText)
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
                .tag(Tab.search)
                
                // Favorites tab
                MovieList(movies: favorites.map { MovieModel(withDbModel: $0) })
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Favorites")
                }
                .tag(Tab.favorites)
            }
            .onChange(of: searchText) { value in
                viewModel.getMovies(searchTerm: value)
            }
            .navigationTitle(tabTitle(currentTab))
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

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
