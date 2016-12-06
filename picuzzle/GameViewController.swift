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
    
    func gameOverPoints(_ points: Int){
        /* Function for future use? */
        print("callback")
        
        let finalScore = NSEntityDescription.insertNewObject(forEntityName: "AAAScore", into: context) as! AAAScore
        finalScore.setValue(points, forKey: "value")
        finalScore.setValue(self.selectedMode, forKey: "type")
         
        do {
            try finalScore.managedObjectContext?.save()
        } catch {
            print(error)
        }
        
        performSegue(withIdentifier: "gameoverSegue", sender: points)
        /*
        switch _selectedMode{
        case "Time Attack":
            print("Time Attack")
        case "Time Trial":
            print("Time Trial")
        default:
            print("Time Attack")
        }*/
        //self.gameoverScene.setResult(result: points)
        //performSegue(withIdentifier: "back", sender: nil)
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
