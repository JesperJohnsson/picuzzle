//
//  Matrix.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-11-17.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation
import UIKit

let NR_OF_COLUMNS = 5
let NR_OF_ROWS = 3
let ELEMENT_WIDTH = 75
let ELEMENT_HEIGHT = 75
let BG_GRAY = UIColor(red: 239.0 / 255, green: 239.0 / 255, blue: 239.0 / 255, alpha: 1.0)
let BG_ORANGE = UIColor(red: 244.0 / 255, green: 109.0 / 255, blue: 41.0 / 255, alpha: 1.0)
let BG_YELLOW = UIColor(red: 246.0 / 255, green: 219.0 / 255, blue: 124.0 / 255, alpha: 1.0)

class Matrix{
    var matrix: [[Element?]]
    var nrOfRows: Int
    var nrOfColumns: Int
    
    init(rows: Int, columns: Int)
    {
        self.nrOfColumns = columns
        self.nrOfRows = rows
        
        self.matrix = [[Element?]]()
        for row in 0..<rows
        {
            var element = [Element?]()
            
            for column in 0..<columns
            {
                element.append(nil)
            }
            self.matrix.append(element)
        }
    }
    
    func createElements(){
        var arr = [Element]()
        
        arr.append(Element(row: 0, column: 1, id: 1, sp: "green.png"))
        arr.append(Element(row: 0, column: 1, id: 1, sp: "green.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "red.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "red.png"))
        
        arr.append(Element(row: 0, column: 1, id: 3, sp: "yellow.png"))
        arr.append(Element(row: 0, column: 1, id: 3, sp: "yellow.png"))
        
        arr.append(Element(row: 0, column: 1, id: 4, sp: "blue.png"))
        arr.append(Element(row: 0, column: 1, id: 4, sp: "blue.png"))
        
        arr.append(Element(row: 0, column: 1, id: 5, sp: "orange.png"))
        arr.append(Element(row: 0, column: 1, id: 5, sp: "orange.png"))
        
        arr.append(Element(row: 0, column: 1, id: 6, sp: "black.png"))
        arr.append(Element(row: 0, column: 1, id: 6, sp: "black.png"))
        
        arr.append(Element(row: 0, column: 1, id: 7, sp: "white.png"))
        arr.append(Element(row: 0, column: 1, id: 7, sp: "white.png"))
        
        arr.append(Element(row: 0, column: 1, id: 8, sp: "pink.png"))
        arr.append(Element(row: 0, column: 1, id: 8, sp: "pink.png"))
        self.rangElementsRandom(arr: arr)
    }
    
    func rangElementsRandom(arr: [Element]){
        var test = arr
        var randomPos = Int(arc4random_uniform(UInt32(arr.count - 1)))
        
        for row in 0..<NR_OF_ROWS{
            for column in 0..<NR_OF_COLUMNS{
                var tempElem = test.remove(at: randomPos)
                tempElem.setCordinates(row: row, column: column)
                
                self.matrix[row][column] = tempElem
                
                if(test.count == 0){
                    //nothing
                }else{
                    randomPos = Int(arc4random_uniform(UInt32(test.count - 1)))}
            }
        }
        //self.matrix[0][0] = test.remove(at: 0)
        
    }
    
    func getNrOfElements()->Int{
        var nrOfElements = 0
        for row in 0..<NR_OF_ROWS{
            for column in 0..<NR_OF_COLUMNS{
                if(self.matrix[row][column] != nil){
                   nrOfElements = nrOfElements + 1
                }
            }
        }
        return nrOfElements
    }
    
    func getElement(row: Int, column: Int)->Element?{
        return self.matrix[row][column]
    }
    
    func removeElement(row: Int, column: Int){
        self.matrix[row][column] = nil
    }
    
    func initiateElements(){
        for row in 0..<NR_OF_ROWS{
            for column in 0..<NR_OF_COLUMNS{
                self.matrix[row][column] = Element(row: row, column: column)
            }
        }
        self.createElements()
    }
    
}
