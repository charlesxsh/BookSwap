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
    var queryUrlStr:String!
    var collectionName:String!
    
    init(collectionName:String) {
        self.queryJson = [String: AnyObject](minimumCapacity: 3)
        self.collectionName = collectionName
        self.queryUrlStr = "\(BSGlobal.baseUrl)/query/\(self.collectionName)"
        debugPrint("BSQuery:\(queryUrlStr)")
    }

    func whereKey(key:String, equalTo value:AnyObject) {
        self.queryJson[key] = value
    }

    func query(callback:(BSError?, [BSObject]?)->Void) {
        debugPrint("Query \(self.queryUrlStr):\(self.queryJson)")
        let url = NSURL(string: self.queryUrlStr)
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
            guard data != nil else {
                callback(BSError(_errorStr: "Null return for query \(self.collectionName):\(self.queryJson)"), nil)
                return
            }
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