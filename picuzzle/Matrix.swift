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
let DEVICE_SCREEN_SIZE = UIScreen.main.bounds
func getElementSize()->Int{
    print("DEVICE HEIGHT: " + String(describing: DEVICE_SCREEN_SIZE.size.height))
    print("DEVICE WIDTH: " + String(describing: DEVICE_SCREEN_SIZE.size.width))
    if(DEVICE_SCREEN_SIZE.height == 568 && DEVICE_SCREEN_SIZE.width == 320){
        return 50
    }
    return 75
}
let ELEMENT_WIDTH = getElementSize()
let ELEMENT_HEIGHT = getElementSize()

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
        
        /*
        var count = (NR_OF_COLUMNS*NR_OF_ROWS) / 2
        
        print("cOUNT " + String(count))
        
        for var i in 1..<count + 1{
            arr.append(Element(row: 0, column: 1, id: i, sp: String(i) + "_1.png"))
            arr.append(Element(row: 0, column: 1, id: i, sp: String(i) + "_2.png"))
        }*/
        
        arr.append(Element(row: 0, column: 1, id: 1, sp: "1_1.png"))
        arr.append(Element(row: 0, column: 1, id: 1, sp: "1_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "2_1.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "2_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 3, sp: "3_1.png"))
        arr.append(Element(row: 0, column: 1, id: 3, sp: "3_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 4, sp: "4_1.png"))
        arr.append(Element(row: 0, column: 1, id: 4, sp: "4_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 5, sp: "5_1.png"))
        arr.append(Element(row: 0, column: 1, id: 5, sp: "5_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 6, sp: "6_1.png"))
        arr.append(Element(row: 0, column: 1, id: 6, sp: "6_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 7, sp: "7_1.png"))
        arr.append(Element(row: 0, column: 1, id: 7, sp: "7_2.png"))
        
        arr.append(Element(row: 0, column: 1, id: 8, sp: "8_1.png"))
        arr.append(Element(row: 0, column: 1, id: 8, sp: "8_2.png"))
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
