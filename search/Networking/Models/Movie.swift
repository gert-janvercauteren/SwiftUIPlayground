import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let name: String
    
    let genre: String
    
    let imageUrl: String
    let description: String?
    
    var price: String {
        if let trackPrice = trackPrice {
            return "\(String(format: "%.2f", trackPrice)) \(currency)"
        }
        
        return "FREE"
    }
    
    private let trackPrice: Double?
    private let currency: String

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case trackPrice
        case currency
        case genre = "primaryGenreName"
        case imageUrl = "artworkUrl60"
        case description = "longDescription"
    }
    
    init(name: String, price: Double, genre: String) {
        self.id = 1
        self.currency = "AUD"
        self.name = name
        self.trackPrice = price
        self.genre = genre
        self.imageUrl = "https://example.com"
        self.description = ""
    }
}
