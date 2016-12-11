//
//  Message.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-12-11.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation

class Message: NSObject, NSCopying{
    var message: String
    
    override init(){
        message = "undefined"
    }
    
    init(message: String){
        self.message = message
    }
    
    func setMessage(message: String){
        self.message = message
    }
    
    func getMessage()->String{
        return self.message
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Message(message: message)
        return copy
    }
}
