import SwiftUI

struct EmptyView: View {
    
    var iconName: String
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .symbolRenderingMode(.hierarchical)
                .frame(width: 150, height: 150)
                .foregroundColor(color)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(subtitle)
                .multilineTextAlignment(.center)
                .font(.subheadline)
        }
        .padding()
        .foregroundColor(.gray)
    }
}

extension EmptyView {
    static var loadingMovies = EmptyView(iconName: "bolt.square.fill",
                                   title: "search.title.loading",
                                   subtitle: "search.subtitle.loading",
                                   color: .green)
    
    static var emptyMovies = EmptyView(iconName: "magnifyingglass.circle.fill",
                                       title: "search.title.empty",
                                       subtitle: "search.subtitle.empty",
                                       color: .blue)
    
    static var noResultsMovies = EmptyView(iconName: "cloud.rain.fill",
                                           title: "No results :(",
                                           subtitle: "Try: Star wars",
                                           color: .orange)
    
    static var emptyFavorites = EmptyView(iconName: "heart.circle.fill",
                                          title: "favorites.title.empty",
                                          subtitle: "favorites.subtitle.empty",
                                          color: .red)
}

struct EmptyFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(iconName: "heart.square.fill",
                  title: "No favorites yet",
                  subtitle: "Search your favorite movies and add them to your list",
                  color: .red)
    }
}
