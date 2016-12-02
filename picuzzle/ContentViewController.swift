//
//  ContentViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-02.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet var highscoreList: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var highscore: Highscore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleText
        self.highscore.addScore(score: Score(value: 1))
        self.highscore.addScore(score: Score(value: 5))
        self.highscore.addScore(score: Score(value: 13))
        self.highscore.addScore(score: Score(value: 11))
        self.highscore.addScore(score: Score(value: 9))
        
        print(self.highscoreList.count)
        
        for i in 0..<self.highscore.getCount() {
            self.highscoreList[i].text = String(self.highscore.getScore(index: i).value)
            print(self.highscore.getScore(index: i).value)
        }
    }
}
