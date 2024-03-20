
import UIKit


final class MainViewController: UITableViewController {

    private let networkManager = NetworkManager.shared

    private var musicTracks: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        
        fetchHotTracks()
    }

    // MARK: - Table view data source
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        musicTracks.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicTrackCell", for: indexPath)
        guard let cell = cell as? MusicTrackCell else { return UITableViewCell() }
        let track = musicTracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
}

// MARK: - Networking
extension MainViewController {

    private func fetchHotTracks() {
        networkManager.fetchHotTracks(from: Link.hotTracksURL.url) {
            [unowned self] result in
            switch result {
            case .success(let trackList):
                musicTracks = trackList.tracks
                tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(
                    title: "Failure",
                    message: "You can see error in the Debug aria",
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                
                present(alert, animated: true)
                print(error)
            }
        }
    }
    
}
