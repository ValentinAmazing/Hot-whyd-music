
import Foundation


struct TrackList: Decodable {
    let tracks: [Track]
}

struct Track: Decodable {
    let name: String
    let img: URL?
    let trackUrl: String
}

