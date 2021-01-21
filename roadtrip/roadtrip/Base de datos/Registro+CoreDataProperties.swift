//
//  Registro+CoreDataProperties.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 21/01/2021.
//  Copyright © 2021 ual. All rights reserved.
//
//

import Foundation
import CoreData


extension Registro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Registro> {
        return NSFetchRequest<Registro>(entityName: "Registro")
    }

    @NSManaged public var a01: Float
    @NSManaged public var a02: Float
    @NSManaged public var a03: Float
    @NSManaged public var a04: Float
    @NSManaged public var a05: Float
    @NSManaged public var a06: Float
    @NSManaged public var fecha: NSDate?
    @NSManaged public var nombre: String?
    @NSManaged public var satelite: Bool
    @NSManaged public var ejex: Float
    @NSManaged public var ejey: Float
    @NSManaged public var usuario: Usuario?

}
