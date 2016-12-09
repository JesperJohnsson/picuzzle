//
//  ContentViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-02.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

class ContentViewController: UIViewController {
    
    @IBOutlet weak var highscoreList: UIStackView!
    //@IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imagePath: String!
    var dataLocation: Int!
    var location: String!
    //var highscore: Highscore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view?.backgroundColor = UIColor(white: 1, alpha: 0)
        //self.view?.backgroundColor = UIColor.brown
        
        print("viewDidLoad:ContentViewController")
        print(dataLocation)
        
        switch dataLocation {
        case 0:
            getLocalData()
        case 1:
            getGlobalData()
        default:
            getLocalData()
        }
        
    }
    
    func resetHighscoreList() {
        self.image.image = UIImage(named: self.imagePath)
        
        for i in 0..<5 {
            let currentIndex = i + 1
            let currentStackView = highscoreList.subviews[i]
            let firstPart = currentStackView.subviews[0] as! UILabel
            
            firstPart.text = "\(currentIndex)."
            let secondPart = currentStackView.subviews[1] as! UILabel
            secondPart.text = "-"
        }
    }
    
    func getLocalData() {
        resetHighscoreList()
        let scoresFetch = NSFetchRequest<AAAScore>(entityName: "AAAScore")
        let predicate = NSPredicate(format: "type = %@", self.titleText)
        let valueSort = NSSortDescriptor(key: "value", ascending: false)
        scoresFetch.sortDescriptors = [valueSort]
        scoresFetch.predicate = predicate
        scoresFetch.fetchLimit = 5
        
        do {
            let fetchedScores = try context.fetch(scoresFetch)
            
            for i in 0..<fetchedScores.count {
                let correctIndex = i + 1
                let userName = fetchedScores[i].userName
                let score = String(fetchedScores[i].value)
                let currentStackView = highscoreList.subviews[i]
            
                let firstPart = currentStackView.subviews[0] as! UILabel
                firstPart.text = "\(correctIndex). \(userName!)"
                let secondPart = currentStackView.subviews[1] as! UILabel
                secondPart.text = "\(score)p"
            }
            
        } catch {
            print(error)
        }
    }
    
    func getGlobalData() {
        resetHighscoreList()
        
        var ref = FIRDatabase.database().reference()

        if(location == "timeattack") {
            ref = FIRDatabase.database().reference(withPath: "timeattack")
        } else if(location == "timetrial") {
            ref = FIRDatabase.database().reference(withPath: "timetrial")
        } else if(location == "multiplayer") {
            ref = FIRDatabase.database().reference(withPath: "multiplayer")
        }
        
        ref.queryOrdered(byChild: "value").observe(.value, with: { snapshot in
            let highscoreList = Highscore()
            
            for snapshotScore in snapshot.children {
                let score = Score(snapshot: snapshotScore as! FIRDataSnapshot)
                highscoreList.addScore(score: score)
            }
            
            for i in 0..<highscoreList.getCount() {
                let score = highscoreList.getScore(index: i)
                
                let correctIndex = i + 1
                let userName = score.userName
                let value = score.value
                let currentStackView = self.highscoreList.subviews[i]
                
                print("\(correctIndex). \(userName) \(value)p")
                let firstPart = currentStackView.subviews[0] as! UILabel
                firstPart.text = "\(correctIndex). \(userName)"
                let secondPart = currentStackView.subviews[1] as! UILabel
                secondPart.text = "\(value)p"
            }
        })
    }
}
