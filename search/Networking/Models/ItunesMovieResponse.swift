import Foundation

struct ItunesMovieResponse: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
