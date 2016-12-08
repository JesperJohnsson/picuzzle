//
//  GameViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-17.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreData
import FirebaseDatabase

class GameViewController: UIViewController {
    
    private var _selectedMode: String!
    
    var selectedMode: String {
        get {
            return _selectedMode
        } set {
            _selectedMode = newValue
        }
    }

    var gameboardScene: GameScene!
    var gameoverScene: GMScene!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.isMultipleTouchEnabled = false
        
        self.gameoverScene = GMScene(size: skView.bounds.size)
        
        self.gameboardScene = GameScene(size: skView.bounds.size)
        
        self.gameboardScene.name = "gameboard"
        self.gameboardScene.gameInitiate(mode: _selectedMode)
        gameboardScene.scaleMode = .aspectFill
        skView.presentScene(self.gameboardScene)
    
        gameboardScene.pointsHandler = gameOverPoints
        
        var s = skView.scene!
        print("SCENE NAME")
        print(String(describing: s.name))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func gameOverPoints(_ points: Int){
        var ref = FIRDatabase.database().reference(withPath: "scores")
        
        if(_selectedMode == "Time Attack") {
            ref = FIRDatabase.database().reference(withPath: "timeattack")
        } else if(_selectedMode == "Time Trial") {
            ref = FIRDatabase.database().reference(withPath: "timetrial")
        } else if(_selectedMode == "Multiplayer") {
            ref = FIRDatabase.database().reference(withPath: "multiplayer")
        }
        
        let scoreRef = ref.child(randomString(length: 32))
        
        let finalScore = NSEntityDescription.insertNewObject(forEntityName: "AAAScore", into: context) as! AAAScore
        
        let defaults = UserDefaults.standard
        if let userName = defaults.string(forKey: "userNameKey") {
            finalScore.setValue(userName, forKey: "userName")
            scoreRef.setValue(["userName": userName, "value": points])
        } else {
            finalScore.setValue("Anonymous", forKey: "userName")
            scoreRef.setValue(["userName": "Anonymous", "value": points])
        }
        
        finalScore.setValue(points, forKey: "value")
        finalScore.setValue(_selectedMode, forKey: "type")
         
        do {
            try finalScore.managedObjectContext?.save()
        } catch {
            print(error)
        }
        
        performSegue(withIdentifier: "gameoverSegue", sender: points)
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FinishedScreenViewController {
            if let points = sender as? Int{
                destination.points = points
            }
        }
    }
    
}
