//
//  Highscore.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-20.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation

class Highscore {
    private var scores = [Score]()
    private let maxNumberOfScores = 5
    
    func addScore(score: Score) {
        if scores.count == 0 || scores.count < maxNumberOfScores {
            scores.append(score)
        } else {
            for i in 0..<scores.count {
                if score.value > scores[i].value {
                    scores[scores.count - 1].value = score.value
                    break
                }
            }
        }
        
        scores = scores.sorted(by: {$0.value > $1.value})
    }
}
