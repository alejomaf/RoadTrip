import UIKit

class InformacionViewController: UIViewController {
 
    @IBOutlet weak var nombreApp: UILabel!
    @IBOutlet weak var iconoApp: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        #if imaginRoad
            nombreApp.text = "imaginRoad"
            iconoApp.image = UIImage(named: "imaginRoad")
        #elseif TripTok
            nombreApp.text = "TripTok"
            iconoApp.image = UIImage(named: "TripTok")
        #else
            nombreApp.text = "error"
            iconoApp.image = nil
        #endif
    }
}
