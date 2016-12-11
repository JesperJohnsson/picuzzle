import UIKit
import CoreData
import FacebookCore
import FacebookLogin

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

class IndexViewController: UIViewController {

    @IBOutlet weak var informationTxtLbl: UILabel!
    @IBOutlet weak var insertNameTxtFld: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var highscoreBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            print(accessToken)
            print("accessToken is sets")
        }
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        
        /*if let userName = defaults.string(forKey: "userNameKey") {
            setUserNameInformation(name: userName)
            insertNameTxtFld.isHidden = false
            playBtn.isHidden = false
            highscoreBtn.isHidden = false
            settingsBtn.isHidden = false
        } else {
            playBtn.isHidden = true
            highscoreBtn.isHidden = true
            settingsBtn.isHidden = true
        }*/
        
        playBtn.isHidden = true
        highscoreBtn.isHidden = true
        settingsBtn.isHidden = true
    
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
