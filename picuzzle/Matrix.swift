//
//  Matrix.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-11-17.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation

let NR_OF_COLUMNS = 4
let NR_OF_ROWS = 4

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
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "yellow.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "yellow.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "blue.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "blue.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "orange.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "orange.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "black.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "black.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "white.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "white.png"))
        
        arr.append(Element(row: 0, column: 1, id: 2, sp: "pink.png"))
        arr.append(Element(row: 0, column: 1, id: 2, sp: "pink.png"))
        self.rangElementsRandom(arr: arr)
    }
    
    func rangElementsRandom(arr: [Element]){
        var test = arr
        var randomPos = Int(arc4random_uniform(UInt32(arr.count - 1)))
        
        for row in 0..<NR_OF_ROWS{
            for column in 0..<NR_OF_COLUMNS{
                print(test.count)
                self.matrix[row][column] = test.remove(at: randomPos)
                
                if(test.count == 0){
                //nothing
                }else{
                randomPos = Int(arc4random_uniform(UInt32(test.count - 1)))}
            }
        }
        //self.matrix[0][0] = test.remove(at: 0)
        
    }
    
    func initiateElements(){
        for row in 0..<NR_OF_ROWS{
            for column in 0..<NR_OF_COLUMNS{
                self.matrix[row][column] = Element(row: row, column: column)
            }
        }
        self.createElements()
    }
    
    func getElement(row: Int, column: Int)->Element{
        return self.matrix[row][column]!
    }
    
}
