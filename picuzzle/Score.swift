//
//  Score.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-20.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation

class Score {
    private var _value: Int!
    
    var value: Int {
        get {
            return _value
        } set {
            _value = newValue
        }
    }
    
    init(value: Int) {
        _value = value
    }
}
