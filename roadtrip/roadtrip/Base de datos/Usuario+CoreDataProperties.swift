//
//  Usuario+CoreDataProperties.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 21/01/2021.
//  Copyright © 2021 ual. All rights reserved.
//
//

import Foundation
import CoreData


extension Usuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest<Usuario>(entityName: "Usuario")
    }

    @NSManaged public var contrasena: String?
    @NSManaged public var correo: String?
    @NSManaged public var nombre: String?
    @NSManaged public var ejex: Float
    @NSManaged public var ejey: Float
    @NSManaged public var registros: NSOrderedSet?

}

// MARK: Generated accessors for registros
extension Usuario {

    @objc(insertObject:inRegistrosAtIndex:)
    @NSManaged public func insertIntoRegistros(_ value: Registro, at idx: Int)

    @objc(removeObjectFromRegistrosAtIndex:)
    @NSManaged public func removeFromRegistros(at idx: Int)

    @objc(insertRegistros:atIndexes:)
    @NSManaged public func insertIntoRegistros(_ values: [Registro], at indexes: NSIndexSet)

    @objc(removeRegistrosAtIndexes:)
    @NSManaged public func removeFromRegistros(at indexes: NSIndexSet)

    @objc(replaceObjectInRegistrosAtIndex:withObject:)
    @NSManaged public func replaceRegistros(at idx: Int, with value: Registro)

    @objc(replaceRegistrosAtIndexes:withRegistros:)
    @NSManaged public func replaceRegistros(at indexes: NSIndexSet, with values: [Registro])

    @objc(addRegistrosObject:)
    @NSManaged public func addToRegistros(_ value: Registro)

    @objc(removeRegistrosObject:)
    @NSManaged public func removeFromRegistros(_ value: Registro)

    @objc(addRegistros:)
    @NSManaged public func addToRegistros(_ values: NSOrderedSet)

    @objc(removeRegistros:)
    @NSManaged public func removeFromRegistros(_ values: NSOrderedSet)

}
