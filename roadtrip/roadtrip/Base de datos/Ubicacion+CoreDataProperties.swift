//
//  Ubicacion+CoreDataProperties.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 09/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//
//

import Foundation
import CoreData


extension Ubicacion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ubicacion> {
        return NSFetchRequest<Ubicacion>(entityName: "Ubicacion")
    }

    @NSManaged public var horizontal: Double
    @NSManaged public var vertical: Double

}
