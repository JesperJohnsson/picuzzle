//
//  ContentViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-02.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import CoreData

class ContentViewController: UIViewController {
    
    @IBOutlet var highscoreList: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var highscore: Highscore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scoresFetch = NSFetchRequest<AAAScore>(entityName: "AAAScore")
        let predicate = NSPredicate(format: "type = %@", self.titleText)
        scoresFetch.predicate = predicate
        
        do {
            let fetchedScores = try context.fetch(scoresFetch)
            self.highscore.clearScores()
            
            for s in 0..<fetchedScores.count {
                print(fetchedScores[s].value)
                
                self.highscore.addScore(score: Score(value: Int(fetchedScores[s].value)))
            }
            
            self.titleLabel.text = self.titleText
            
            for i in 0..<self.highscore.getCount() {
                self.highscoreList[i].text = "\(i + 1). " + String(self.highscore.getScore(index: i).value) + "p"
                print(self.highscore.getScore(index: i).value)
            }
        } catch {
            print(error)
        }
        
        
    }
    
}
