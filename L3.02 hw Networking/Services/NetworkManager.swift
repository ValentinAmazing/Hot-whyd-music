
import Foundation


enum Link {
    case hotTracksURL
    
    var url: URL {
        URL(string: "https://openwhyd.org/hot?format=json")!
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchHotTracks() {
        URLSession.shared.dataTask(with: Link.hotTracksURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let TrackList = try JSONDecoder().decode(TrackList.self, from: data)
                print(TrackList)
            } catch {
                print(error)
            }
        }.resume()
    }
}
