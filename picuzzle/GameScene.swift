//
//  GameScene.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-17.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var matrix: Matrix
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override init(size: CGSize){
        self.matrix = Matrix(rows: NR_OF_ROWS,columns: NR_OF_COLUMNS)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.setupGame()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    /* necessary game functions */
    func setupGame()
    {
        var xPosition = 0 //125/2
        var yPosition = 667
        var rows = NR_OF_ROWS
        var columns = NR_OF_COLUMNS
        matrix.initiateElements()
        
        var tempPosY = 0
        for row in 0..<rows{
            var tempPosX = 0
            for column in 0..<columns{
                var element = matrix.getElement(row: row, column: column)
                if(element != nil){
                    let background = element.sprite
                    background.anchorPoint = CGPoint(x: 0, y: 1)
                    background.size = CGSize(width: 50.0, height: 50.0)
                    background.position = CGPoint(x:xPosition + tempPosX, y:yPosition + tempPosY);
                    self.addChild(background)
                }
                tempPosX = tempPosX + 50
            }
            tempPosY = tempPosY - 50
            tempPosX = 0
        }
    }

    
    
}
