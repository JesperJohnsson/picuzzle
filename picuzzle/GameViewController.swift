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
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        
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
    
    func gameOverPoints(_ points: Int){
        var ref = FIRDatabase.database().reference(withPath: "scores")
        let defaults = UserDefaults.standard
        let highscoreList = Highscore()
        
        if(_selectedMode == "Time Attack") {
            ref = FIRDatabase.database().reference(withPath: "timeattack")
        } else if(_selectedMode == "Time Trial") {
            ref = FIRDatabase.database().reference(withPath: "timetrial")
        } else if(_selectedMode == "Multiplayer") {
            ref = FIRDatabase.database().reference(withPath: "multiplayer")
        }
        
        ref.queryOrdered(byChild: "value").observeSingleEvent(of: .value, with: { snapshot in
            
            for snapshotScore in snapshot.children {
                let score = Score(snapshot: snapshotScore as! FIRDataSnapshot)
                highscoreList.addScore(score: score)
            }
            
            if let userName = defaults.string(forKey: "userNameKey") {
                highscoreList.addScore(score: Score(value: points, userName: userName))
            } else {
                highscoreList.addScore(score: Score(value: points, userName: "Anonymous"))
            }
            
            for i in 0..<highscoreList.getCount() {
                let score = highscoreList.getScore(index: i)
                let scoreRef = ref.child("child\(i)")
                scoreRef.setValue(["userName": score.userName, "value": score.value])
                
            }
        })
        
        let finalScore = NSEntityDescription.insertNewObject(forEntityName: "AAAScore", into: context) as! AAAScore
        
        if let userName = defaults.string(forKey: "userNameKey") {
            finalScore.setValue(userName, forKey: "userName")
        } else {
            finalScore.setValue("Anonymous", forKey: "userName")
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
                destination.mode = _selectedMode
            }
        }
    }
    
}
