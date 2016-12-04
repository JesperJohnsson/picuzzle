//
//  Grab.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-11-20.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation

class Grab{
    var element: Element?
    
    init(element: Element){
        self.element = element
    }
    
    init(){
        self.element = Element()
    }
    
    func getElement()->Element{
        return self.element!
    }
    
    func setElement(element: Element){
        self.element = element
    }
    
    func clearElement(){
        self.element = Element()
    }
    
    func print(){
        //print(String(self.element))
    }
}
