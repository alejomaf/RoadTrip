//
//  Ubicacion+CoreDataProperties.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 21/01/2021.
//  Copyright © 2021 ual. All rights reserved.
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
    @NSManaged public var usuario: Usuario?
    @NSManaged public var registro: Registro?

}
