import UIKit
import CoreData

class IndexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        self.view.insertSubview(backgroundImage, at: 0)

        // Do any additional setup after loading the view.
        
        if Reachability.isConnectedToNetwork() {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
