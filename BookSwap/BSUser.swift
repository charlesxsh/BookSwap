//
//  BSUser.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BSUser: BSObject {
    
    var email:String? {
        get {return super.params["email"] as? String}
        set(newStr) {super.params["email"] = newStr}
    }
    
    var password:String? {
        get {return super.params["password"] as? String}
        set(newStr) {super.params["password"] = newStr}
    }
    
    var displayName:String? {
        get {return super.params["displayname"] as? String }
        set(newStr) {super.params["displayname"] = newStr}
    }
    
    var profie:UIImage? {
        get{ return UIImage(data:super.params["profie"] as! NSData) }
        set(img) {super.params["profie"] = UIImagePNGRepresentation(img!)}
    }
    
    init(Email _email:String!,Password _password:String!,Displayname _displayname:String!, Profie _profie:UIImage?) {
        super.init(ParameterCapacity: 3)
        super.params["email"] = _email
        super.params["password"] = _password
        super.params["displayname"] = _displayname
        super.params["profie"] = _profie
    }
    
    func signUp(callback:(BSError?, BSUser?)->Void) {
        super.save("") { (data, reponse, error) -> Void in
            do{
                let jsondata = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                let status:String = jsondata["status"] as! String
                if status == "OK" {
                    super.objectId = jsondata["id"] as? String
                    callback(nil, self)
                }
                else {
                    callback(BSError(_errorStr: status), nil)
                }
            }catch let error as NSError {
                callback(BSError(_errorStr: error.description), nil)
            }
        }
    }
    
    static func signIn(Email _email:String!,Password _password:String!, callback:(BSError?)->Void) {
        let url = NSURL(string: "")
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        let tempDict = ["email":_email, "password": _password]
        var data:NSData?
        
        do {
            data = try NSJSONSerialization.dataWithJSONObject(tempDict, options: .PrettyPrinted)
        } catch let err {
            debugPrint(err)
        }
        
        request.HTTPBody = data
        
        
        let task =  NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data, reponse, err) ->Void in
            let result:BSResult = BSUtil.jsonToBSResult(data)
            if !result.isError() {
                callback(nil)
            }else {
                callback(BSError(_errorStr: result.status))
            }
        }
        task.resume()
    }
}
