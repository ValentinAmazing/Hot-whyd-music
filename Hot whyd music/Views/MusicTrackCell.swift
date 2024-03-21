
import UIKit


final class MusicTrackCell: UITableViewCell {
   
    
    @IBOutlet private var imageButton: UIButton!
    @IBOutlet private var trackNameLabel: UILabel!
    
    private var networkManager = NetworkManager.shared
       
    
    func configure(with track: Track) {
        trackNameLabel.text = track.name
        
        guard let trackImgURL = track.img else {return}

        networkManager.fetchImage(from: trackImgURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                imageButton.setImage(UIImage(data: imageData), for: .normal)
            case .failure(let error):
                print(error)
            }
        }
    }

}
