
import UIKit


final class MusicTrackCell: UITableViewCell {
   
    @IBOutlet private var imageButton: UIButton!
    @IBOutlet private var trackNameLabel: UILabel!
    @IBOutlet private var playIconButton: UIButton!
        
    private var isMusicPlaing = false
    private var networkManager = NetworkManager.shared
       
    @IBAction func touchButton() {
        let iconPlayPause = isMusicPlaing ? "play.fill" : "pause.fill"
        
        playIconButton.setImage(UIImage(systemName: iconPlayPause), for: .normal)
        isMusicPlaing.toggle()
    }
    
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

