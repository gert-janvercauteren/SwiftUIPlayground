import Foundation
import Combine

enum ItunesEndpoint {
    case getMovies(query: String)
}

extension ItunesEndpoint {
    var path: String {
        switch self {
        case .getMovies:
            return "search"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getMovies(let query):
            return [
                URLQueryItem(name: "term", value: query),
                URLQueryItem(name: "country", value: "au"),
                URLQueryItem(name: "media", value: "movie"),
                URLQueryItem(name: "all", value: nil)
            ]
        }
    }
}

enum ItunesAPI {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://itunes.apple.com")!
}

extension ItunesAPI {
    static func request(_ endpoint: ItunesEndpoint) -> AnyPublisher<ItunesMovieResponse, Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        
        components.queryItems = endpoint.queryItems
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
