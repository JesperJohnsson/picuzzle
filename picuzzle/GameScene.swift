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
    var gameBoard: SKNode
    var grab: Grab
    var nrOfElements: Int
    
    /* SET GRAB CLAS */
    
    override init(size: CGSize){
        self.matrix = Matrix(rows: NR_OF_ROWS,columns: NR_OF_COLUMNS)
        self.gameBoard = SKNode()
        self.grab = Grab()
        self.nrOfElements = ELEMENT_HEIGHT * ELEMENT_WIDTH
        
        let TileWidth: CGFloat = 50.0
        let TileHeight: CGFloat = 50.0
        let gamePos = CGPoint(
            x: -TileWidth * CGFloat(ELEMENT_WIDTH) / 2,
            y: -TileHeight * CGFloat(ELEMENT_HEIGHT) / 2)
        self.gameBoard.position = gamePos
        
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
        let touch = touches.first as UITouch!
        let location = touch?.location(in: self.gameBoard)
        print(location)
        
        let (success, rowen, columnen) = convertPoint(location!)
        if success{
            let foundElement = self.matrix.getElement(row: rowen, column: columnen)
            
            /* SET ELEMENT INTO GRAB */
            print(foundElement.id)
            var prevElem = self.grab.getElement()
            
            if(foundElement.row == prevElem.row && foundElement.column == prevElem.column){
                //nothing
                print("SAME ELEMENT")
                self.animateInActiveElement(elem: foundElement)
                self.grab.clearElement()
            }
            else{
                self.animateActiveElement(elem: foundElement)
                if(foundElement.id == self.grab.getElement().id){
                    print("ITS A MATCH!")
                }
                self.grab.setElement(element: foundElement)
            }
        }
        else{ print("miss")}
    }
    
    func removeElement(){
        
    }
    
    func comareElements(){
    
    }
    
    func animateInActiveElement(elem: Element){
        var monsterSprite = elem.sprite
        monsterSprite.zPosition = 100
        var time = 0.2
        let scale = SKAction.scale(by: 0.5, duration: time)
        monsterSprite.run(scale)
    }
    
    func animateActiveElement(elem: Element){
        var monsterSprite = elem.sprite
        monsterSprite.zPosition = 100
        var time = 0.2
        let scale = SKAction.scale(by: 2.0, duration: time)
        let colorize = SKAction.colorize(with: .black,colorBlendFactor: 1, duration: 2)
        monsterSprite.run(colorize)
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
                    background.size = CGSize(width: CGFloat(ELEMENT_WIDTH), height: CGFloat(ELEMENT_HEIGHT))
                    background.position = CGPoint(x:xPosition + tempPosX, y:yPosition + tempPosY);
                    self.addChild(background)
                }
                tempPosX = tempPosX + 50
            }
            tempPosY = tempPosY - 50
            tempPosX = 0
        }
    }
    
    func convertPoint(_ point: CGPoint) -> (success: Bool, row: Int, column: Int)
    {
        let TileHeight = CGFloat(50)
        let TileWidth = CGFloat(50)
        if point.x >= 0 && point.x < CGFloat(NR_OF_ROWS)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NR_OF_COLUMNS)*TileHeight{
            return (true, Int(point.y / TileHeight), Int(point.x / TileWidth))
            
        } else{
            return (false, 0, 0)  // invalid location
            print("false")
        }
    }
    
    func gameOver(){
    //let trans = SKTransition.fade(withDuration: 0.5)
    //let goScene = GameOverScene(size: self.size)
    //self.view?.presentScene(goScene, transisition: trans)
    }
}
