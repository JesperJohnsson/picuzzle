//
//  GMScene.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-11-23.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GMScene: SKScene {
    var resultLabel: SKLabelNode
    //var backToMainButton: SKLabelNode
    
    override init(size: CGSize){
        self.resultLabel = SKLabelNode(fontNamed:"Arial")
        //self.resultLabel.text = "Game Over"
        self.resultLabel.fontSize = 100
        
        super.init(size: size)
        self.resultLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        addChild(self.resultLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        print("flipped scene")
        let backToMainBtn = SKSpriteNode(imageNamed: "red")
        backToMainBtn.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 200)
        backToMainBtn.name = "Back"
        addChild(backToMainBtn)
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    func setResult(result: Int){
        print("skriver ut resultat")
        print(result)
        self.resultLabel.text = String(result)
    }
    
    
}
