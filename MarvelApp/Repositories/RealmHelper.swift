//
//  RealmHelper.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/22/23.
//

import Foundation
import RealmSwift

class RealmHelper: NSObject {
    /// path for realm file
    lazy private var realmURL: URL = {
        let url = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.MarvelApp")!
            .appendingPathComponent("default.realm")
        return url
    }()
    lazy private var config:Realm.Configuration = {
        return Realm.Configuration(
            fileURL: self.realmURL,
            inMemoryIdentifier: nil,
            readOnly: false,
            schemaVersion: 1,
            migrationBlock: nil,
            deleteRealmIfMigrationNeeded: false,
            objectTypes: nil)
    }()
    
    static let shared: RealmHelper = RealmHelper()
    
    func save<T: CollectionItemProtocol & Object>(data:[T], model: T.Type) {
            let realm = try! Realm(configuration: config)

            try! realm.write(){
                realm.add(data)
            }
        }

    func getDataBy<T: CollectionItemProtocol & Object>(characterID: Int, model: T.Type) -> [T] {
        let realm = try! Realm(configuration: config)
        let messagesDb =  realm.objects(model.self)
        let dataResult = messagesDb.filter("characterID == %@", characterID)
        
        return Array(dataResult)
    }

}
