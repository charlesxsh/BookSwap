//
//  BSBook.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BSBook:BSObject{
    
    var bookName:String? {
        get {return super.params["bookemail"] as? String }
        set(newStr) {super.params["bookemail"] = newStr}
    }
    
    var authorName:String?{
        get {return super.params["authorname"] as? String }
        set(newStr) {super.params["authorname"] = newStr}
    }
    
    var edition:Int?{
        get {return Int(super.params["authorname"] as! String) }
        set(newStr) {super.params["authorname"] = String(newStr)}
    }
    
    var coverImg:UIImage?{
        get {return UIImage(data: super.params["coverimage"]! as! NSData) }
        set(img) {super.params["coverimage"] = UIImagePNGRepresentation(img!)}
    }
    
    init(Bookname _bn:String!, Authorname _an:String?, Edition e:Int?, Coverimage img:UIImage?) {
        super.init(ParameterCapacity: 4)
        self.bookName = _bn
        self.authorName = _an
        self.edition = e
        self.coverImg = img
    }
    
    func save(callback:(BSError?, MongoBase?)->Void){
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

