//
//  SettingsViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-06.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var userNameTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let userName = defaults.string(forKey: "userNameKey") {
            userNameTxtFld.text = userName
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigation()
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        let defaults = UserDefaults.standard
        defaults.set(sender.text!, forKey: "userNameKey")
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
}
