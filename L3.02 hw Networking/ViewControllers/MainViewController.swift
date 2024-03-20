
import UIKit


final class MainViewController: UITableViewController {

    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchHotTracks()
    }

}

