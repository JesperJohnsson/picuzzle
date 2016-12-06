//
//  FinishedScreenViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-28.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import CoreData

import SpriteKit
import GameplayKit

class FinishedScreenViewController: UIViewController {

    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var textResultLbl: UILabel!
    var points: Int!
    var mode: String!
    
    override func viewDidLoad() {
        
        //super.viewDidLoad()
        
        //var hs = Highscore()
        print("FINISHED " + String(points))
        print(mode)
        pointLbl.text = String(points)
        
        /* Funkar för Time attack
         Returnerar en boolean om score hamnar i highscore
         */
        //self.lookIfHighscore()
        
    }
    
    func lookIfHighscore(){
        var highScoreExists = self.newHighscore()
        if(highScoreExists){
            self.animateHighscore()
        }
    }
    
    func animateHighscore(){
        print("animation******")
    }
    
    func newHighscore()->Bool{
        var highscore = Highscore()
        
        let scoresFetch = NSFetchRequest<AAAScore>(entityName: "AAAScore")
        let predicate = NSPredicate(format: "type = %@", self.mode)
        scoresFetch.predicate = predicate
        
        do {
            let fetchedScores = try context.fetch(scoresFetch)
            highscore.clearScores()
            
            for s in 0..<fetchedScores.count {
                highscore.addScore(score: Score(value: Int(fetchedScores[s].value)))
            }
            
            for i in 0..<highscore.getCount() {
                if(self.points > highscore.getScore(index: i).value){
                    print("NEW HIGHSCORE")
                    return true
                }
            }
            
        } catch {
            print(error)
        }
        return false
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //Clears all of the pre existing views so they do not occupy memory and cause problems
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }

}
