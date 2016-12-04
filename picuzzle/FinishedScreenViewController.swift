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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
