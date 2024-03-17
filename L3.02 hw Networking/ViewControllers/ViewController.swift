
import UIKit

enum Link {
    case hotTracksURL
    
    var url: URL {
        URL(string: "https://openwhyd.org/hot?format=json")!
    }
}

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// MARK: - Networking

extension ViewController {
    private func fetchHotTracks() {
        URLSession.shared.dataTask(with: Link.hotTracksURL.url) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                showAlert(withStatus: .success)
                print(course)
            } catch {
                showAlert(withStatus: .failed)
                print(error)
            }
            
        }.resume()
    }
}
