
import UIKit

enum Link {
    case hotTracksURL
    
    var url: URL {
        URL(string: "https://openwhyd.org/hot?format=json")!
    }
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHotTracks()
    }

    // MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchHotTracks() {
        URLSession.shared.dataTask(with: Link.hotTracksURL.url) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            DispatchQueue.main.async { [unowned self] in
                do {

                    let TrackList = try JSONDecoder().decode(TrackList.self, from: data)
                    showAlert(withStatus: .success)
                    print(TrackList)

                } catch {
                    showAlert(withStatus: .failed)
                    print(error)
                }
            }
            
        }.resume()
    }
}
