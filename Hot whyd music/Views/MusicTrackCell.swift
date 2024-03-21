
import UIKit


final class MusicTrackCell: UITableViewCell {
   
    @IBOutlet private var imageButton: UIButton!
    @IBOutlet private var trackNameLabel: UILabel!
    @IBOutlet private var playIconButton: UIButton!
        
    private var isMusicPlaing: Bool = false
    private var networkManager = NetworkManager.shared
       
    @IBAction func touchButton() {
        if isMusicPlaing {
            playIconButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            isMusicPlaing.toggle()
        } else {
            playIconButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            isMusicPlaing.toggle()
        }
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

