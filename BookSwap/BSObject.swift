//
//  MongoBaseObject.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BSObject {
    
    internal var params:[String:AnyObject]!
    
    internal var objectId:String?
    
    subscript(key: String) -> AnyObject {
        get {
            return self.params[key]!
        }
        set(Value) {
            self.params[key] = Value
        }
    }
    
    internal init() {
        params = [String:String](minimumCapacity: 3)
    }
    
    internal init(ParameterCapacity c:Int) {
        params = [String:String](minimumCapacity: c)
    }
    
    
    //transfer dictionary to json
    internal func toJsonData()->NSData?{
        if self.params.isEmpty { return nil }
        
        var data:NSData?
        do {
            data = try NSJSONSerialization.dataWithJSONObject(self.params, options: .PrettyPrinted)
        } catch let err {
            debugPrint(err)
        }
        return data
    }
    
    
    
    //save object to given url using json
    internal func save(url:String!,completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let url = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = self.toJsonData()
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
}

