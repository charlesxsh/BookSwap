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

class BSOnlist:BSObject{
    
    var bookName:String? {
        get {return super.params["bookemail"] as? String }
        set(newStr) {super.params["bookemail"] = newStr}
    }
    
    var authorName:String?{
        get {return super.params["authorname"] as? String }
        set(newStr) {super.params["authorname"] = newStr}
    }
    
    var edition:Int?{
        get {return Int(super.params["edition"] as! String) }
        set(newStr) {super.params["edition"] = String(newStr)}
    }
    
    var coverImg:UIImage?{
        get {return UIImage(data: super.params["coverimage"]! as! NSData) }
        set(img) {super.params["coverimage"] = UIImagePNGRepresentation(img!)}
    }
    
    var sellPrice:Int?{
        get {return Int(super.params["sellprice"] as! String) }
        set(newStr) {super.params["sellprice"] = String(newStr)}
    }

    var rentPrice:Int?{
        get {return Int(super.params["rentprice"] as! String) }
        set(newStr) {super.params["rentprice"] = String(newStr)}
    }

    var ifSwap:Bool?{
        get {return ((super.params["ifswap"] as! String) == "true") }
        set(newStr) {super.params["ifSwap"] = (String(newStr) == "true" ? true:false)}
    }

    var BelongTo:BSUser?
    
    override init() {
        super.init(ParameterCapacity: 8)
    }
    
    func upLoad(callback:(BSError?)->Void){
        self.params["belongto"] = self.BelongTo?.objectId
        self.save("") { (data, response, error) -> Void in
            let result:BSResult = BSUtil.jsonToBSResult(data)
            if !result.isError() {
                callback(nil)
            }else {
                callback(BSError(_errorStr: result.status))
            }
        }
        
    }
    
    
}
