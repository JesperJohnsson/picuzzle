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
    var nrOfClicks: Int
    var timer: Timer
    var seconds: Int
    var label: SKLabelNode
    var result: SKLabelNode
    var mode: String
    
    /* TEST VARIABLES*/
    var points: Int
    var pointsHandler: ((Int) -> ())?
    
    /* SET GRAB CLAS */
    
    override init(size: CGSize){
        self.mode = "Time Attack"
        self.matrix = Matrix(rows: NR_OF_ROWS,columns: NR_OF_COLUMNS)
        self.gameBoard = SKNode()
        self.grab = Grab()
        self.nrOfElements = ELEMENT_HEIGHT * ELEMENT_WIDTH
        self.points = 0
        
        let TileWidth: CGFloat = 50.0
        let TileHeight: CGFloat = 50.0
        let gamePos = CGPoint(
            x: -TileWidth * CGFloat(ELEMENT_WIDTH) / 2,
            y: -TileHeight * CGFloat(ELEMENT_HEIGHT) / 2)
        self.gameBoard.position = gamePos
        self.nrOfClicks = 0
        self.timer = Timer()
        self.seconds = 0
        self.label = SKLabelNode(fontNamed:"Arial")
        self.result = SKLabelNode(fontNamed:"Arial")
        
        super.init(size: size)
        
        self.label.text = "00.00";
        self.label.fontSize = 45;
        self.label.position = CGPoint(x:self.frame.midX, y:self.frame.maxY - 100);
        self.addChild(self.label)
        
        self.result.text = String(self.points);
        self.result.fontSize = 30;
        self.result.position = CGPoint(x:self.frame.midX, y:self.frame.maxY - 50);
        self.addChild(self.result)
    }
    
    func gameInitiate(mode: String){
        switch mode{
        case "Time Attack":
            self.mode = "Time Attack"
            self.setTimeAttackTimer()
        case "Time Trial":
            self.mode = "Time Trial"
            self.setTimeTrialTimer()
        default:
            self.mode = "Time Attack"
        }
    }
    
    func setPoint(){
        self.points += 1
        self.result.text = String(self.points)
    }
    
    func getPoints()->Int{
        return self.points
    }
    
    func setTimeAttackTimer(){
        /* TIDEN GÅR NER */
        self.seconds = 40
        label.text = String(self.seconds)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.counterDown), userInfo: nil, repeats: true)
    }
    
    func setTimeTrialTimer(){
        /* TIDEN GÅR NER */
        self.seconds = 0
        label.text = String(self.seconds)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.counterUp), userInfo: nil, repeats: true)
    }
    
    func counterUp(){
        self.seconds += 1
        label.text = String(self.seconds)
        if(self.matrix.getNrOfElements() == 0){
            self.timer.invalidate()
            
            if let handler = pointsHandler {
                let points = self.points
                handler(points)
            }
        }
    }
    
    func counterDown(){
        self.seconds -= 1
        label.text = String(self.seconds)
        if(self.seconds == 0){
            self.timer.invalidate()
            
            if let handler = pointsHandler {
                let points = self.points
                handler(points)
            }
        }
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
        print("location: " + String(describing: location))
        
        let (success, rowen, columnen) = convertPoint(location!)
        if success{
            let foundElement = self.matrix.getElement(row: rowen, column: columnen)!
            self.nrOfClicks += 1
            
            /* SET ELEMENT INTO GRAB */
            var prevElem = self.grab.getElement()
            
            if(foundElement.row == prevElem.row && foundElement.column == prevElem.column && self.nrOfClicks == 2){
                //nothing
                print("SAME ELEMENT")
                self.animateInActiveElement(elem: foundElement)
                self.grab.clearElement()
            }
            else{
                self.animateActiveElement(elem: foundElement)
                if(foundElement.id == self.grab.getElement().id && self.nrOfClicks == 2){
                    self.nrOfClicks = 0
                    self.removeElement(element: self.grab.getElement())
                    self.removeElement(element: foundElement)
                    self.setPoint()
                    print("1")
                    print(self.matrix.getNrOfElements())
                    if(self.mode == "Time Attack" && self.matrix.getNrOfElements() == 0){
                        print("GAME OVER")
                        self.createAndShuffleElems()
                    }
                }
                else if(self.nrOfClicks == 2){
                    print("not same element");
                    self.nrOfClicks = 0
                    self.animateInActiveElement(elem: self.grab.getElement())
                    self.animateInActiveElement(elem: foundElement)
                }
                self.grab.setElement(element: foundElement)
            }
            
        }
        else{ print("miss")}
    }
    
    func createAndShuffleElems(){
        self.matrix.createElements();
        self.setupGame();
    }
    
    func removeElement(element: Element){
        var tempElem: Element?
        tempElem = element
        
            
        if let sprite = tempElem?.sprite {
            if sprite.action(forKey: "removing") == nil {
                print("PANG PUNG")
                let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                scaleAction.timingMode = .easeOut
                sprite.run(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                           withKey:"removing")
                self.matrix.removeElement(row: (tempElem?.row)!, column: (tempElem?.column)!)
            }
        }
    }
    
    func comareElements(){
    
    }
    
    func animateInActiveElement(elem: Element){
        var monsterSprite = elem.sprite
        monsterSprite.zPosition = 10
        var time = 0.1
        let scale = SKAction.scale(by: 0.8, duration: time)
        monsterSprite.run(scale)
    }
    
    func animateActiveElement(elem: Element){
        var monsterSprite = elem.sprite
        monsterSprite.zPosition = 100
        var time = 0.1
        let scale = SKAction.scale(by: 1.25, duration: time)
        let colorize = SKAction.colorize(with: .black,colorBlendFactor: 1, duration: 2)
        monsterSprite.run(scale)
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
    func setupGame(){
        var middle = self.view?.center;
        
        var gamePosMiddleX = (ELEMENT_WIDTH * NR_OF_COLUMNS) / 2
        var gamePosMiddleY = (ELEMENT_HEIGHT * NR_OF_ROWS) / 2
        
        var xPosition = Int(middle!.x) - gamePosMiddleX //125/2
        var yPosition = Int(middle!.y) + gamePosMiddleY //667
        var rows = NR_OF_ROWS
        var columns = NR_OF_COLUMNS
        matrix.initiateElements()
        
        print("start positions")
        print(xPosition)
        print(yPosition)
        var tempPosY = 0
        for row in 0..<rows{
            var tempPosX = 0
            for column in 0..<columns{
                var element = matrix.getElement(row: row, column: column)
                if(element != nil){
                    let background = element!.sprite
                    //background.anchorPoint = CGPoint(x: 0, y: 1) // 0, 1
                    background.size = CGSize(width: CGFloat(ELEMENT_WIDTH), height: CGFloat(ELEMENT_HEIGHT))
                    background.position = CGPoint(x:xPosition + tempPosX + 25, y:yPosition + tempPosY - 25);
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
        var middle = self.view?.center;
        
        var gamePosMiddleX = (ELEMENT_WIDTH * NR_OF_COLUMNS) / 2
        var gamePosMiddleY = (ELEMENT_HEIGHT * NR_OF_ROWS) / 2
        
        var xPosition = Int(middle!.x) - gamePosMiddleX //125/2
        var yPosition = Int(middle!.y) + gamePosMiddleY
        
        let TileHeight = CGFloat(50)
        let TileWidth = CGFloat(50)
        if point.x >= CGFloat(87) && point.x < CGFloat(87) + CGFloat(NR_OF_ROWS)*TileWidth &&
            point.y >= CGFloat(235) && point.y < CGFloat(235) + CGFloat(NR_OF_COLUMNS)*TileHeight{
            print("koordinater")
            print(point.y/TileHeight)
            print(point.x/TileWidth)
            return (true, Int((point.y - 235)/TileHeight), Int((point.x - 87)/TileWidth))
            
        } else{
            print("false")
            return (false, 0, 0)  // invalid location
        }
    }
    
    func convPoint(_ fingerPoint: CGPoint) -> (success: Bool, row: Int, column: Int){
        let tHeight = CGFloat(ELEMENT_WIDTH)
        let tWidth = CGFloat(ELEMENT_HEIGHT)
        if(fingerPoint.x >= 0 && fingerPoint.x < CGFloat(NR_OF_ROWS)*tWidth &&
            fingerPoint.y >= 0 && fingerPoint.y < CGFloat(NR_OF_COLUMNS)*tHeight){
            return (true, Int(fingerPoint.y / tHeight - 25), Int(fingerPoint.x / tWidth))
        }
        else{
            return (false, -1, -1)
        }
    }
    
    func gameOver(){
        //let trans = SKTransition.fade(withDuration: 0.5)
        let trans = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
        let goScene = GMScene(size: self.size)
        goScene.name = "gameover scene"
        goScene.setResult(result: self.points)
        self.view?.presentScene(goScene, transition: trans)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        /*if (segue.identifier == "gameover")
        {
            let DestViewController : GMScene = segue.destView as! GMScene
        }*/
    }
}
