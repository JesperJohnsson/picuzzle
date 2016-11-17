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
    
    func initiateElements(){
        for row in 0..<NR_OF_ROWS{
            for column in 0..<NR_OF_COLUMNS{
                self.matrix[row][column] = Element(row: row, column: column)
            }
        }
    }
    
    func getElement(row: Int, column: Int)->Element{
        return self.matrix[row][column]!
    }
    
}
