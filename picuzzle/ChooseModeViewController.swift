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

    /*
    @IBOutlet weak var singlePlayerView: UIView!

    @IBOutlet weak var multiplayerView: UIView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var localBtn: UIButton!
     */
    
    @IBAction func timeAttackBtnPressed(_ sender: Any) {
        print("KÖR")
        performSegue(withIdentifier: "GameViewController", sender: "Time Attack")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //singlePlayerView.layer.cornerRadius = 10
        timeAttackBtn.layer.cornerRadius = 10
        //timeTrialBtn.layer.cornerRadius = 10
        //multiplayerView.layer.cornerRadius = 10
        //onlineBtn.layer.cornerRadius = 10
        //localBtn.layer.cornerRadius = 10
        
        self.initiate()
    }
    
    func initiate(){
         self.view.backgroundColor = BG_GRAY
    }

    
    @IBAction func timeTrialBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameViewController", sender: "Time Trial")
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
