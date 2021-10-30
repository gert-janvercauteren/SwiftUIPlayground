import SwiftUI

struct EmptyView: View {
    
    var iconName: String
    var title: String
    var subtitle: String
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

struct EmptyFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(iconName: "heart.square.fill",
                  title: "No favorites yet",
                  subtitle: "Search your favorite movies and add them to your list",
                  color: .red)
    }
}
