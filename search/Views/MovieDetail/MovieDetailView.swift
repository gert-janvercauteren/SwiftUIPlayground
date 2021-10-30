import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    
    var body: some View {
        VStack {
            MovieRow(movie: movie)
            Text(movie.description ?? "No description available")
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .toolbar {
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "heart")
                    .accessibilityLabel("Add to favorites ")
                    .tint(.red)
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(name: "Test", price: 3.00, genre: "Test"))
    }
}
