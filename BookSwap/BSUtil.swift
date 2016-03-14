//
//  BSUtil.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/8/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

struct BSUtil{
    //transfer nsdata to json
    static func jsonToBSResult(data:NSData!)->BSResult?{

        var returnResult = BSResult()
        do {
            let tempData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [String:AnyObject]
            let status = tempData["status"] as! String
            returnResult.status = status
            let results = tempData["results"] as? [[String:AnyObject]]
            guard results != nil else{
                return returnResult
            }
            for r in results! {
                returnResult.addResult(BSObject(json: r))
            }
        }catch let err{
            debugPrint(err)
            return nil
        }
        
        return returnResult
    }
    
    static func jsonToDictionary(data:NSData!)->[String:AnyObject]? {

        var dict:[String:AnyObject]?
        do {
            dict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
        } catch let err {
            debugPrint(err)
            return nil
        }
        
        return dict
    }
    
}