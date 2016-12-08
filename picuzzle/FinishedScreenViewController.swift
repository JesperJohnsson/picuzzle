//
//  FinishedScreenViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-28.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class FinishedScreenViewController: UIViewController {

    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var textResultLbl: UILabel!
    var points: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FINISHED " + String(points))
        pointLbl.text = String(points)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //Clears all of the pre existing views so they do not occupy memory and cause problems
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }

}
