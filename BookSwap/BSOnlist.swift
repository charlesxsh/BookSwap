//
//  BSOnlist.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/6/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

//var onlistSchema = new Schema({
//    BookName:String,
//    Author:String,
//    Edition:Number,
//    coverImg:{data: Schema.Types.Buffer, contentType:String},
//    SellPrice:Number,
//    RentPrice:Number,
//    BelongTo:{
//        type: mongoose.Schema.Types.ObjectId,
//        ref: 'User'
//    },
//    Swap:Boolean
//});

public class BSOnlist:BSObject{
    
    public var bookName:String? {
        get {return super.params["bookName"] as? String }
        set(newStr) {super.params["bookName"] = newStr}
    }
    
    public var authorName:String?{
        get {return super.params["authorName"] as? String }
        set(newStr) {super.params["authorName"] = newStr}
    }
    
    public var edition:Int?{
        get { return super.params["edition"] as? Int }
        set(newVal) { super.params["edition"] = newVal }
    }
    
    public var coverImg:UIImage? {
        get{ return UIImage(data:NSData(base64EncodedString: super.params["coverImg"] as! String, options:[])!) }
        set(img) {
            let imgdata = UIImagePNGRepresentation(img!)!
            let imgstr = imgdata.base64EncodedStringWithOptions([])
            super.params["coverImg"] = imgstr
        }
    }
    
    public var sellPrice:Float?{
        get {return super.params["sellPrice"] as? Float }
        set(newVal) {super.params["sellPrice"] = newVal }
    }

    public var rentPrice:Float?{
        get {return super.params["rentPrice"] as? Float }
        set(newVal) {super.params["rentPrice"] = newVal }
    }

    public var swap:Bool?{
        get {return super.params["swap"] as? Bool }
        set(newVal) {super.params["swap"] = newVal }
    }

    public var belongTo:BSUser?
    
    override init() {
        super.init(ParameterCapacity: 8)
    }
    
    func upLoad(callback:(BSError?)->Void){
        let urlStr = "\(BSGlobal.baseUrl)/OnList/add"
        self.params["belongTo"] = self.belongTo?.objectId
        self.save(urlStr) { (data, response, error) -> Void in
            guard data != nil else {
                callback(BSError(_errorStr: "nil data return for \(urlStr)"))
                return
            }
            let result:BSDictRef = BSUtil.jsonToDictionary(data)!
            let status = result["status"] as! String
            if status != "OK" {
                callback(BSError(_errorStr: status))
            }else {
                let objId = result["id"] as! String
                self.objectId = objId
                callback(nil)
            }
        }
        
    }
    
    
}
