
import UIKit


final class MainViewController: UITableViewController {

    private let networkManager = NetworkManager.shared

    private var trackList: [TrackList] = [] // без массива не получилось инициализировать(
    private var musicTracks: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHotTracks()
        if !trackList.isEmpty {
            musicTracks = trackList[0].tracks
        }
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
        print("func tableView() cellForRowAt")
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
                self.trackList.append(trackList)
                print(trackList)
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
