//
//  BSUser.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

public class BSUser: BSObject {
    
    public var email:String? {
        get {return super.params["email"] as? String}
        set(newStr) {super.params["email"] = newStr}
    }
    
    public var password:String? {
        get {return super.params["password"] as? String}
        set(newStr) {super.params["password"] = newStr}
    }
    
    public var displayName:String? {
        get {return super.params["displayName"] as? String }
        set(newStr) {super.params["displayName"] = newStr}
    }
    
    public var profie:UIImage? {
        get{ return UIImage(data:NSData(base64EncodedString: super.params["profie"] as! String, options:[])!) }
        set(img) {
            let imgdata = UIImagePNGRepresentation(img!)!
            let imgstr = imgdata.base64EncodedStringWithOptions([])
            super.params["profie"] = imgstr
        }
    }
    
    public init(Email _email:String!,Password _password:String!,Displayname _displayname:String!, Profie _profie:UIImage?) {
        super.init(ParameterCapacity: 3)
        self.displayName = _displayname
        self.email = _email
        self.password = _password
        self.profie = _profie
    }
    
    public override init() {
        super.init()
    }
    
    public static func logOut(callback:(BSError?)->Void) {
        BSGlobal.currentUser = nil
        callback(nil)
    }
    
    public func signUp(callback:(BSError?, BSUser?)->Void) {
        let urlStr = "\(BSGlobal.baseUrl)/User/signup"
        super.save(urlStr) { (data, reponse, error) -> Void in
            guard data != nil else {
                callback(BSError(_errorStr: "Signup:\(urlStr): null data"), nil)
                return
            }
            do{
                let jsondata = try NSJSONSerialization.JSONObjectWithData(data!, options: [.MutableContainers]) as! [String: AnyObject]
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
    
    public static func signIn(Email _email:String!,Password _password:String!, callback:(BSError?)->Void) {
        let urlStr = "\(BSGlobal.baseUrl)/User/signin"
        let url = NSURL(string: urlStr)
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
            guard data != nil else {
                callback(BSError(_errorStr: "Null data return for \(urlStr):\(tempDict)"))
                return
            }
            let result:BSDictRef? = BSUtil.jsonToDictionary(data)
            guard result != nil else {
                callback(BSError(_errorStr: "BSUser: Cannot parse returned json"))
                return
            }
            if result!["status"] as!String != "OK" {
                callback(BSError(_errorStr: result!["status"] as! String))
            }else {
                let currUser:BSUser = BSUser()
                currUser.email = _email
                currUser.displayName = result!["DisplayName"] as? String
                let imgStr = result!["Profie"] as! String
                let imgData = NSData(base64EncodedString: imgStr, options: [])
                let img:UIImage = UIImage(data: imgData!)!
                currUser.profie = img
                currUser.objectId = result!["id"] as? String
                BSGlobal.currentUser = currUser
                callback(nil)
            }
        }
        task.resume()
    }
    
    
}
