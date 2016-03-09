//
//  BSResult.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/8/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

public struct BSResult {
    public var status:String?
    public var results:[BSDictRef]?
    
    public func isError()->Bool{
        return self.status != "OK"
    }
    
    init(status:String!, results:[BSDictRef]?) {
        self.status = status
        self.results = results
    }
}
