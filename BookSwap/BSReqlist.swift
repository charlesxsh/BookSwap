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
        get {return super.params["bookName"] as? String }
        set(newStr) {super.params["bookName"] = newStr}
    }
    
    var authorName:String?{
        get {return super.params["authorName"] as? String }
        set(newStr) {super.params["authorName"] = newStr}
    }
    
    var edition:Int?{
//        get {return Int(super.params["edition"] as! String) }
//        set(newStr) {super.params["edition"] = String(newStr!)}
        get {return super.params["edition"] as? Int }
        set(newInt) { super.params["edition"] = newInt }
    }
    
    var belongTo:BSUser?
    
    override init() {
        super.init(ParameterCapacity: 4)
    }
    
    func upLoad(callback:(BSError?)->Void){
        //self.params["belongto"] = self.BelongTo?.objectId
        let urlStr = "\(BSGlobal.baseUrl)/RequestList/add"
        self.params["belongTo"] = belongTo?.objectId!
        
        self.save(urlStr) { (data, response, error) -> Void in
            let _result:BSResult? = BSUtil.jsonToBSResult(data)
            
            guard let result = _result else {
                callback(BSError(_errorStr: "Failed to parse json result:\(urlStr)"))
                return
            }
            
            if !result.isError() {
                callback(nil)
            }else {
                callback(BSError(_errorStr: result.status))
            }
        }
    }
    
//    static func search(str:String, callback:(BSError?, [BSObject]?)->Void){
//        let url = NSURL(string: "http://127.0.0.1:8080/api/search/request")
//        let request = NSMutableURLRequest(URL: url!)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.HTTPMethod = "POST"
//        let searchStr = ["search":str]
//        var data:NSData?
//        
//        do {
//            data = try NSJSONSerialization.dataWithJSONObject(searchStr, options: .PrettyPrinted)
//        } catch let err {
//            debugPrint(err)
//        }
//        request.HTTPBody = data
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
//            print(String(data: data!, encoding: NSUTF8StringEncoding))
//            let result:BSResult! = BSUtil.jsonToBSResult(data)
//            if result.isError() {
//                callback(BSError(_errorStr: result.status), nil)
//            }else{
//                callback(BSError(_errorStr: result.status), result.results)
//            }
//            
//            
//        }
//        task.resume()
//    }
}
