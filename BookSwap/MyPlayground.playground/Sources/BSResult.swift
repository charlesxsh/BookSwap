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
    public var results:[BSObject]?
    
    public func isError()->Bool{
        return self.status != BSStatus.OK
    }
    
    public mutating func addResult(r:BSObject?) {
        self.results?.append(r!)
    }
    
    init(status:String!) {
        self.status = status
        self.results = [BSObject]()
    }
    
    init(){
        self.results = [BSObject]()
    }
}

