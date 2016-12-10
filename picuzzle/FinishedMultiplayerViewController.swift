//
//  FinishedMultiplayerViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-10.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class FinishedMultiplayerViewController: UIViewController {
    
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var player2WantsRematch: UILabel!
    
    @IBOutlet weak var outcomeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player2WantsRematch.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func rematchBtnPressed(_ sender: Any) {
    }
}
