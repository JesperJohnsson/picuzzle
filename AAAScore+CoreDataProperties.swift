//
//  AAAScore+CoreDataProperties.swift
//  
//
//  Created by Jesper Johnsson on 2016-12-07.
//
//

import Foundation
import CoreData


extension AAAScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AAAScore> {
        return NSFetchRequest<AAAScore>(entityName: "AAAScore");
    }

    @NSManaged public var type: String?
    @NSManaged public var value: Int16
    @NSManaged public var userName: String?

}
