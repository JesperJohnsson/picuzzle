//
//  HighscoreViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-20.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var highscores: NSArray!
    var imageBadge: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageBadge = UIImageView()
        
        self.pageTitles = NSArray(objects: "Time Attack", "Time Trial", "Multiplayer")
        self.highscores = NSArray(objects: Highscore(), Highscore(), Highscore())
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(origin: CGPoint(x: 0,y: 60), size: CGSize(width: self.view.frame.width, height: self.view.frame.height - 60))
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        self.initiate()
    }
    
    func initiate(){
        imageBadge = UIImageView(frame:CGRect(x: self.view.frame.midX - 37, y: 120, width: 75, height: 75))
        imageBadge.image = UIImage(named:"sword-badge")
        self.view.addSubview(imageBadge)
        self.view.sendSubview(toBack: imageBadge)
        
        /*
        let backgroundImage = UIImageView(frame:CGRect(x: 0, y: self.view.frame.maxY - 100, width: 750, height: 100))
        backgroundImage.image = UIImage(named: "foot1.png")
        self.view.insertSubview(backgroundImage, at: 0)
        */
        
        self.view.backgroundColor = BG_GRAY
    }
    
    func changeBadge(atIndex: Int){
        print(atIndex)
        switch(atIndex){
        case 0:
            imageBadge.image = UIImage(named:"sword-badge")
            break
        case 1:
            imageBadge.image = UIImage(named:"clock-badge")
            break
        case 2:
            imageBadge.image = UIImage(named:"multiplayer-badge")
            break
        default:
            imageBadge.image = UIImage(named:"sword-badge")
            break
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController {
        
        self.changeBadge(atIndex: index)
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        vc.titleText = self.pageTitles[index] as! String
        print("title text")
        print(vc.titleText)
        vc.highscore = self.highscores[index] as! Highscore
        vc.pageIndex = index
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
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
    
    
    
    
}
