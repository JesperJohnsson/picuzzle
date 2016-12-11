//
//  LoginViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-11.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var test: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            print("This is a test")
            loginBtn.isHidden = true
            print(accessToken)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case.failed(let error):
                print(error)
            case.cancelled:
                print("User cancelled login.")
            case.success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken):
                print(grantedPermissions)
                print(declinedPermissions)
                print(accessToken)
                self.loginBtn.setTitle("LOGOUT", for: .normal)
                print("Logged in!")
                self.getUserData()
            }
        }
    }
    
    func getUserData() {
        let connection = GraphRequestConnection()
        
        connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                print("\(response.dictionaryValue!["id"]!)")
                print("\(response.dictionaryValue!["name"]!)")
                
                self.defaults.set(response.dictionaryValue!["id"]!, forKey: "userIdKey")
                self.defaults.set(response.dictionaryValue!["name"]!, forKey: "userNameKey")
                self.test.text = String(describing: response.dictionaryValue!["name"]!)
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
}
