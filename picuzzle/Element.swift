//
//  Element.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-11-17.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation
import SpriteKit

class Element{
    var row: Int
    var column: Int
    var sprite: SKSpriteNode?
    var id: Int
    
    init(row: Int, column: Int){
        self.id = 0
        self.row = row
        self.column = column
        self.sprite = SKSpriteNode(imageNamed: "example.png")
    }
}
