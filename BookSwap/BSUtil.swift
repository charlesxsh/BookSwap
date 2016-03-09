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
    static func jsonToBSResult(data:NSData!)->BSResult!{
        var result:BSResult?
        do {
            let tempData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let status = tempData["status"] as! String
            let results = tempData["results"] as? [BSDictRef]
            result = BSResult(status: status, results: results)
        }catch let err{
            debugPrint(err)
        }
        return result
    }
}
