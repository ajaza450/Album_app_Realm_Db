//
//  RealmHelper.swift
//  TaskMVVM
//
//  Created by EZAZ AHAMD on 28/01/23.
//

import UIKit
import RealmSwift
class RealmHelper {
    
    // MARK: - Save Object
    static func saveObject<T:Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            let copy = realm.create(Json_album_model.self, value: object, update: .all)
            realm.add(copy, update: .all)
           // realm.add(object)
        }
    }
    // MARK: - Delete Object
    static func realmdeleteObjects() {
        do {
            let realm = try Realm()
            let objects = realm.objects(Json_album_model.self)
            try! realm.write {
                realm.delete(objects)
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
    
    
    static func realmDelete<T:Object>(object: T) {

        do {
            let realm = try Realm()
            try! realm.write {
              realm.delete(object)
               
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
    
    // MARK: - Get Object
    
    static func getObjects<T:Object>()->[T] {
        
        let realm = try! Realm()
        let realmResults = realm.objects(T.self)
        return Array(realmResults)
    }

}
