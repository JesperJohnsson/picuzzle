//
//  ChooseModeViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-28.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class ChooseModeViewController: UIViewController {
    
    
    @IBOutlet weak var timeAttackBtn: UIButton!
    @IBOutlet weak var timeTrialBtn: UIButton!
    @IBOutlet weak var multiplayerLocalBtn: UIButton!
    @IBOutlet weak var multiplayerOnlineBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func timeAttackBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameViewController", sender: "Time Attack")
    }
    
    @IBAction func timeTrialBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameViewController", sender: "Time Trial")
    }
    
    @IBAction func multiplayerLocalBtnPressed(_ sender: Any) {
    }
    
    @IBAction func multiplayerOnlineBtnPressed(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameViewController {
            
            if let mode = sender as? String {
                destination.selectedMode = mode
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigation()
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
}
