//
//  Client+CoreDataProperties.swift
//  atelier
//
//  Created by mac on 07/06/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var code: Int16
    @NSManaged public var nom: String?
    @NSManaged public var prenom: String?
    @NSManaged public var telephone: String?
    @NSManaged public var image: NSData?
    @NSManaged public var lat: String?
    @NSManaged public var lang: String?

}
