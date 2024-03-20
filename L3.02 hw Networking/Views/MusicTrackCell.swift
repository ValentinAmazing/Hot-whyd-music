
import UIKit


final class MusicTrackCell: UITableViewCell {
   
    @IBOutlet private var musicTrackImage: UIImageView!
    @IBOutlet private var trackNameLabel: UILabel!
   
    private var networkManager = NetworkManager.shared
        
    func configure(with track: Track) {
        guard let trackImgURL = track.img else {return}

        networkManager.fetchImage(from: trackImgURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                musicTrackImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}
