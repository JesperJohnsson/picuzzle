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
    var row: Int?
    var column: Int?
    var sprite: SKSpriteNode
    var id: Int
    
    init(){
        self.id = -1
        self.row = -1
        self.column = -1
        self.sprite = SKSpriteNode()
    }
    
    init(row: Int, column: Int){
        self.id = 0
        self.row = row
        self.column = column
        self.sprite = SKSpriteNode(imageNamed: "example.png")
    }
    
    init(row: Int, column: Int, id: Int, sp: String){
        print(sp)
        self.id = id
        self.row = row
        self.column = column
        self.sprite = SKSpriteNode(imageNamed: sp)
    }
    
    func setCordinates(row: Int, column: Int){
        self.row = row
        self.column = column
    }
}
