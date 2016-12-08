//
//  HighscoreCell.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-07.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class HighscoreCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var score: UILabel!
    
    func configureCell(score: AAAScore, index: IndexPath) {
        print("-------")
        print(score.userName!)
        print(score.value)
        print(index)
        print("-------")
        
        self.userName.text = score.userName
        self.score.text = String(score.value)
        self.position.text = String((index[1] + 1)) + "."
    }
    
}
