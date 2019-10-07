//
//  Database.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation
import RealmSwift


protocol Databaseable: class {
    static var shared: Database { get }
    
    var database: Realm? { get }
    
    func get<T: Object>(type: T.Type) -> Results<T>?
    func get<T: Object, K>(type: T.Type, key: K) -> T?
    
    func save(object: Object)
    func save<S: Sequence>(objects: S) where S.Iterator.Element: Object
    
    func delete(object: Object)
    func delete<S>(objects: S) where S : Sequence, S.Element : Object
    func deleteAll()
}

open class Database: Databaseable {
    
    static var shared: Database = Database()
    let currentSchema: UInt64 = 1
    var database: Realm?
    
    private init() {
        database = try! Realm()
    }
    
    /// Get All Object
    /// - Parameter type: type description
    func get<T>(type: T.Type) -> Results<T>? where T : Object {
        guard let database = database else {
            debugPrint("instance not available")
            return nil
        }
        
        return database.objects(type)
    }
    
    
    /// Get on object with key
    /// - Parameter type: type description
    /// - Parameter key: key description
    func get<T, K>(type: T.Type, key: K) -> T? where T : Object {
        guard let database = database else {
            debugPrint("instance not available")
            return nil
        }
        
        return database.object(ofType: type, forPrimaryKey: key)
    }
    
    
    /// Save an Object
    /// - Parameter object: object description
    func save(object: Object) {
        guard let database = database else {
            debugPrint("instance not available")
            return
        }
        
        do {
            try database.write {
                debugPrint(object.description)
                database.add(object, update: .all)
            }
        } catch(let e) {
            debugPrint("ERROR ", e.localizedDescription)
        }
    }
    
    
    /// Save object in array
    /// - Parameter objects: objects description
    func save<S>(objects: S) where S : Sequence, S.Element : Object {
        guard let database = database else {
            debugPrint("instance not available")
            return
        }
        
        do {
            try database.write {
                debugPrint(Array(objects).description)
                database.add(objects, update: .all)
            }
        } catch(let e) {
            debugPrint("ERROR ", e.localizedDescription)
        }
    }
    
    
    /// Delete object
    /// - Parameter object: object description
    func delete(object: Object) {
        guard let database = database else {
            debugPrint("instance not available")
            return
        }
        
        do {
            try database.write {
                debugPrint(object.description)
                database.delete(object)
            }
        } catch(let e) {
            debugPrint("ERROR ", e.localizedDescription)
        }
    }
    
    
    /// Delete object from array
    /// - Parameter objects: objects description
    func delete<S>(objects: S) where S : Sequence, S.Element : Object {
        guard let database = database else {
            debugPrint("instance not available")
            return
        }
        
        do {
            try database.write {
                debugPrint(Array(objects).description)
                database.delete(objects)
            }
        } catch(let e) {
            debugPrint("ERROR ", e.localizedDescription)
        }
    }
    
    
    /// Delete All Data
    func deleteAll() {
        guard let database = database else {
            debugPrint("instance not available")
            return
        }
        
        do {
            try database.write {
                database.deleteAll()
            }
        } catch(let e) {
            debugPrint("ERROR ", e.localizedDescription)
        }
    }
    
}
