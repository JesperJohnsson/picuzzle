//
//  LoadingScreenViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-28.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func abortBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
