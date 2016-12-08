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
    var imageBadge: UIImageView!
    
    @IBOutlet weak var popupView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var hs = Highscore()
        pointLbl.text = String(points)
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        //self.popupView.image = UIImage(named:"clock-badge")!
        self.popupView.isHidden = true
        self.popupView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool){
        self.lookIfHighscore()
    }

    func lookIfHighscore(){
        var highScoreExists = self.newHighscore()
        if(highScoreExists.exists){
            print("SCORE POSITION")
            print(highScoreExists.pos)
            
            switch(highScoreExists.pos){
            case 1:
                self.popupView.image = UIImage(named:"TA-gold-medal")!
                break
            case 2:
                self.popupView.image = UIImage(named:"TA-silver-medal")!
                break
            case 3:
                self.popupView.image = UIImage(named:"TA-BRONZE-medal")!
                break
            default:
                self.popupView.image = UIImage(named:"clock-badge")!
            }
            self.animateHighscore()
        }
    }
    
    func animateHighscore(){
        print("animation******")
        self.popupView.isHidden = false
        UIView.animate(withDuration: 1.0, animations: {
            print("animerar")
            self.popupView.alpha = 1.0
        })
        
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(4000), execute: {
            self.view.isUserInteractionEnabled = true
            
            UIView.animate(withDuration: 1.0, animations: {
                self.popupView.alpha = 0.0
            })
            //self.popupView.isHidden = true
        })
    }
    
    func newHighscore()->(exists: Bool, pos: Int){
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
            
            for i in 0..<4 {
                if(self.points > highscore.getScore(index: i).value){
                    print("NEW HIGHSCORE")
                    //print(i)
                    return (true, i)
                }
            }
            
        } catch {
            print(error)
        }
        return (false, -1)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //Clears all of the pre existing views so they do not occupy memory and cause problems
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }

}
