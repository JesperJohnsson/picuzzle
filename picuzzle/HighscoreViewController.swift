//
//  HighscoreViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-20.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var segementedControl: UISegmentedControl!
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var locations: NSArray!
    //var highscores: NSArray!
    var images: NSArray!
    var imageBadge: UIImageView!
    var currentVC: ContentViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segementedControl.selectedSegmentIndex = 0
        
        self.imageBadge = UIImageView()
        
        self.pageTitles = NSArray(objects: "Time Attack", "Time Trial", "Multiplayer")
        self.locations = NSArray(objects: "timeattack", "timetrial", "multiplayer")
        //self.highscores = NSArray(objects: Highscore(), Highscore(), Highscore())
        self.images = NSArray(objects: "sword-badge", "clock-badge", "multiplayer-badge")
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
        startVC.dataLocation = 0
        currentVC = startVC
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(origin: CGPoint(x: 0,y: 60), size: CGSize(width: self.view.frame.width, height: self.view.frame.height - 60))
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigation()
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentVC.getLocalData()
        case 1:
            currentVC.getGlobalData()
        default:
            currentVC.getLocalData()
        }
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        vc.titleText = self.pageTitles[index] as! String
        vc.location = self.locations[index] as! String
        //vc.highscore = self.highscores[index] as! Highscore
        vc.imagePath = self.images[index] as! String
        
        print("viewControllerAt")
        print(segementedControl.selectedSegmentIndex)
        
        vc.dataLocation = segementedControl.selectedSegmentIndex
        vc.pageIndex = index
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        print("before")
        print(segementedControl.selectedSegmentIndex)
        
        let vc = viewController as! ContentViewController
        vc.dataLocation = segementedControl.selectedSegmentIndex
        var index = vc.pageIndex as Int
        currentVC = vc
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        
        print("after")
        print(segementedControl.selectedSegmentIndex)
        
        vc.dataLocation = segementedControl.selectedSegmentIndex
        var index = vc.pageIndex as Int
        currentVC = vc
        
        if (index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
}
