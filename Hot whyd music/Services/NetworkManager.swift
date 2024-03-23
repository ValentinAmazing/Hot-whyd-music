
import Foundation

///
enum Link {
    case hotTracksURL
    
    var url: URL {
        URL(string: "https://gopenwhyd.org/hot?format=json")!
    }
}
///
enum NetworkError: Error {
    case noData
    case decodingError
}

//MARK: - class NetworkManager
final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    //MARK: - public methods
    func fetchHotTracks(from url: URL, completion: @escaping(Result<TrackList, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: Link.hotTracksURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let trackList = try JSONDecoder().decode(TrackList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(trackList))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
}
