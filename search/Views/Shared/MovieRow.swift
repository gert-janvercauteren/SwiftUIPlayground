import SwiftUI

struct MovieRow: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.imageUrl)!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 40, height: 60)
            VStack(alignment: .leading) {
                Text(movie.name)
                    .font(.headline)
                HStack {
                    Text(movie.genre)
                    Spacer()
                    Text(movie.price)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: Movie(name: "TestMoview", price: 3.99, genre: "Drama"))
    }
}
