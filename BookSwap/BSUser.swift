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
        set(newStr) {super.params["displayname"]}
    }
    
    
    init(Email _email:String!,Password _password:String!,Displayname _displayname:String!) {
        super.init(ParameterCapacity: 3)
        super.params["email"] = _email
        super.params["password"] = _password
        super.params["displayname"] = _displayname
    }
    
    func signUp(callback:(BSError?, User?)->Void){
        super.save(Global.baseUrl) { (data, reponse, error) -> Void in
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
}
