//
//  Player.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-01.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation

class Player {
    private var _name: String = ""
    private var _score: Score?
    
    init(name: String) {
        _name = name
    }
    
    var name: String {
        get {
            return _name
        } set {
            _name = newValue
        }
    }
    
    var score: Score {
        get {
            return _score!
        } set {
            _score = newValue
        }
    }
}
