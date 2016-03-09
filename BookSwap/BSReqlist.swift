//
//  BSReqlist.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/6/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
class BSReqlist:BSObject {
    var bookName:String? {
        get {return super.params["bookname"] as? String }
        set(newStr) {super.params["bookname"] = newStr}
    }
    
    var authorName:String?{
        get {return super.params["authorname"] as? String }
        set(newStr) {super.params["authorname"] = newStr}
    }
    
    var edition:Int?{
        get {return Int(super.params["edition"] as! String) }
        set(newStr) {super.params["edition"] = String(newStr!)}
    }
    
    var BelongTo:BSUser?
    
    override init() {
        super.init(ParameterCapacity: 4)
    }
    
    func upLoad(callback:(BSError?)->Void){
        //self.params["belongto"] = self.BelongTo?.objectId
        self.params["belongto"] = "56d88c8f4af53c557f539179"
        
        self.save("http://127.0.0.1:8080/api/requestlist/add") { (data, response, error) -> Void in
            let result:BSResult = BSUtil.jsonToBSResult(data)
            if !result.isError() {
                callback(nil)
            }else {
                callback(BSError(_errorStr: result.status))
            }
        }
    }
    
    static func search(str:String, callback:(BSError?, [BSDictRef]?)->Void){
        let url = NSURL(string: "http://127.0.0.1:8080/api/search/request")
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        let searchStr = ["search":str]
        var data:NSData?
        
        do {
            data = try NSJSONSerialization.dataWithJSONObject(searchStr, options: .PrettyPrinted)
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
                callback(BSError(_errorStr: result.status), result.results)
            }
            
            
        }
        task.resume()
    }
}
