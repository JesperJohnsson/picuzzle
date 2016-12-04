//
//  AAAScore+CoreDataProperties.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-12-04.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import Foundation
import CoreData


extension AAAScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AAAScore> {
        return NSFetchRequest<AAAScore>(entityName: "AAAScore");
    }

    @NSManaged public var value: Int16
    @NSManaged public var type: String?

}
