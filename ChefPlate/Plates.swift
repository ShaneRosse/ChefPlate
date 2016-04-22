//
//  Plates.swift
//  ChefPlate
//
//  Created by Shane Rosse on 4/9/16.
//  Copyright © 2016 Shane Rosse. All rights reserved.
//

import Foundation
import Firebase

class Plates : NSObject {
    
    let db_url: String = "https://blazing-heat-9345.firebaseio.com/users"
    
    var snap: String?
    var people: Dictionary<String, AnyObject>?
    
    func startUp() {
        let ref = Firebase(url: db_url)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            if (snapshot.value == nil) {
                print("No value from Firebase")
            } else {
                self.people = snapshot.value as? Dictionary
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    func count() -> Int {
        if let data = people {
            return data.count
        } else {
            return 0
        }
    }
    
    func getNames() -> [String] {
        var result: [String] = []
        if let people = people {
            for (key, object) in people {
                print("Garbage timestamp: \(key)")
                if (!result.contains(object as! String)) {
                    result.append(object as! String)
                }
            }
        }
        return result
    }
    
    func cleanUp() {
        let ref = Firebase(url: db_url)
        ref.removeValue()
    }
    
}

