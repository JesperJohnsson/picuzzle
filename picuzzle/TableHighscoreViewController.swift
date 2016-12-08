//
//  TableHighscoreViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-07.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

class TableHighscoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var controller: NSFetchedResultsController<AAAScore>!
    var filterOn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        attemptFetch()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigation()
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoreCell", for: indexPath) as! HighscoreCell
        let score = controller.object(at: indexPath as IndexPath)
        cell.configureCell(score: score, index: indexPath)
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            print("sectionsInfo:", sectionInfo.numberOfObjects)
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            print("sections.count: ", sections.count)
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<AAAScore> = AAAScore.fetchRequest()
        let valueSort = NSSortDescriptor(key: "value", ascending: false)
        
        print("filterOn: ",filterOn)
        let predicate = NSPredicate(format: "type = %@", filterOn)
        fetchRequest.predicate = predicate
        
        fetchRequest.sortDescriptors = [valueSort]
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
            self.tableView.reloadData()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func timeAttackBtnPressed(_ sender: Any) {
        print("Time Attack")
        filterOn = "Time Attack"
        attemptFetch()
    }
    
    @IBAction func timeTrialButtonPressed(_ sender: Any) {
        print("Time Trial")
        filterOn = "Time Trial"
        attemptFetch()
    }
    
    @IBAction func multiplayerBtnPressed(_ sender: Any) {
        print("Multiplayer")
        filterOn = "Multiplayer"
        attemptFetch()
    }
    

    
    
    
    
    
    

}
