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
        get {return super.params["Email"] as? String}
        set(newStr) {super.params["Email"] = newStr}
    }
    
    var password:String? {
        get {return super.params["Password"] as? String}
        set(newStr) {super.params["Password"] = newStr}
    }
    
    var displayName:String? {
        get {return super.params["Displayname"] as? String }
        set(newStr) {super.params["Displayname"] = newStr}
    }
    
    var profie:UIImage? {
        get{ return UIImage(data:super.params["Profie"] as! NSData) }
        set(img) {super.params["Profie"] = UIImagePNGRepresentation(img!)}
    }
    
    init(Email _email:String!,Password _password:String!,Displayname _displayname:String!, Profie _profie:UIImage?) {
        super.init(ParameterCapacity: 3)
        super.params["Email"] = _email
        super.params["Password"] = _password
        super.params["DisplayName"] = _displayname
        super.params["Profie"] = _profie
    }
    /**
     * var userSchema = new Schema({
     Profie:{data: Schema.Types.Buffer, contentType:String},
     DisplayName:String,
     Email:{ type: String, required: true, unique: true },
     Password:String,
     EmailVerified:Boolean,
     CreatedAt:{type:Date, default:Date.now}
     });
     */
    init(jsondata:BSDictRef) {
        super.init(ParameterCapacity: 3)
        self.email = jsondata["Email"] as? String
        self.displayName = jsondata["Password"] as? String
        self.profie = UIImage(data: jsondata["Profie"] as! NSData)
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
