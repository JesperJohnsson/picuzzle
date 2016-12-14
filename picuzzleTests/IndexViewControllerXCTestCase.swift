//
//  IndexViewControllerXCTestCase.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-14.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import XCTest
@testable import picuzzle

class IndexViewControllerXCTestCase: XCTestCase {
    
    var vc: IndexViewController!
    var userAssumedName = "Bengt"
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "IndexViewController") as! IndexViewController
        
        let _ = vc.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testName() {
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: "userNameKey")
        
        if (userAssumedName != "") {
            defaults.set(userAssumedName, forKey: "userNameKey")
        }
        
        if let userName = defaults.string(forKey: "userNameKey") {
            XCTAssert(vc.informationTxtLbl.text == "WELCOME \(userName.uppercased())", "The information label displays WELCOME + the users name")
        } else {
            XCTAssert(vc.informationTxtLbl.text == "ENTER YOUR NAME", "The information label displays ENTER YOUR NAME")
        }
    }
    
}
