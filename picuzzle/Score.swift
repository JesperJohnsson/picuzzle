//
//  Score.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-20.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Score {
    private var _value: Int!
    private var _userName: String!
    
    var value: Int {
        get {
            return _value
        } set {
            _value = newValue
        }
    }
    
    var userName: String {
        get {
            return _userName
        } set {
            _userName = newValue
        }
    }
    
    init(value: Int, userName: String) {
        _value = value
        _userName = userName
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        _value = snapshotValue["value"] as! Int
        _userName = snapshotValue["userName"] as! String
    }
    
}
