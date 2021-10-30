import Foundation

struct ItunesMovieResponse: Codable {
    let movies: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
