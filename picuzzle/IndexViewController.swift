import UIKit
import CoreData

class IndexViewController: UIViewController {

    @IBOutlet weak var informationTxtLbl: UILabel!
    @IBOutlet weak var insertNameTxtFld: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var highscoreBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userName = defaults.string(forKey: "userNameKey") {
            setUserNameInformation(name: userName)
            insertNameTxtFld.isHidden = true
            playBtn.isHidden = false
            highscoreBtn.isHidden = false
            settingsBtn.isHidden = false
        } else {
            playBtn.isHidden = true
            highscoreBtn.isHidden = true
            settingsBtn.isHidden = true
        }
    
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
        
        if let userName = defaults.string(forKey: "userNameKey") {
            setUserNameInformation(name: userName)
        }
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        defaults.set(sender.text!, forKey: "userNameKey")
        setUserNameInformation(name: sender.text!)
        
        insertNameTxtFld.isHidden = true
        playBtn.isHidden = false
        highscoreBtn.isHidden = false
        settingsBtn.isHidden = false
        
        print(sender.text!)
    }
    
    func setUserNameInformation(name: String) {
        informationTxtLbl.text = "WELCOME \(name.uppercased())"
    }
}
