//
//  BSQuery.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/11/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BSQuery {
    var queryJson:[String:AnyObject]!
    var collectionName:String!
    
    init(collectionName:String) {
        self.queryJson = [String: AnyObject](minimumCapacity: 3)
        self.collectionName = collectionName
    }

    func whereKey(key:String, equalTo value:AnyObject) {
        self.queryJson[key] = value
    }

    func query(callback:(BSError?, [BSObject]?)->Void) {
        let url = NSURL(string: "\(BSGlobal.baseUrl)/query/\(self.collectionName)")
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        var data:NSData?

        do {
            data = try NSJSONSerialization.dataWithJSONObject(self.queryJson, options: .PrettyPrinted)
        } catch let err {
            debugPrint(err)
        }
        request.HTTPBody = data
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            print(String(data: data!, encoding: NSUTF8StringEncoding))
            let result:BSResult! = BSUtil.jsonToBSResult(data)
            if result.isError() {
                callback(BSError(_errorStr: result.status), nil)
            }else{
                callback(nil, result.results)
            }


        }
        task.resume()
    }
}