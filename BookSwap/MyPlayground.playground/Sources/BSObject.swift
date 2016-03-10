//
//  MongoBaseObject.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

public class BSObject:NSObject {
    
    internal var params:[String:AnyObject]!
    
    public var objectId:String? {
        get{ return self.params["_id"] as? String }
    }
    
    public subscript(key: String) -> AnyObject? {
        get {
            return self.params[key]
        }
        set(Value) {
            self.params[key] = Value
        }
    }
    
    public override init() {
        params = [String:String](minimumCapacity: 3)
    }
    
    public init(ParameterCapacity c:Int) {
        params = [String:String](minimumCapacity: c)
    }
    
    public init(json:[String:AnyObject]) {
        params = [String:String](minimumCapacity: json.count)
        for (k, v) in json {
            if v is [String:AnyObject] {
                self.params[k] = BSObject(json: v as! [String : AnyObject])
            }else {
                self.params[k] = v
            }
        }
    }
    
    //transfer dictionary to json
    public func toJsonData()->NSData?{
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
    public func save(url:String!,completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let url = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = self.toJsonData()
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
}

