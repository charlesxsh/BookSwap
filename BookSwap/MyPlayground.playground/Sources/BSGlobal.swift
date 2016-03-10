//
//  BSGlobal.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

public struct BSGlobal {

    static let baseUrl:String! = "http://127.0.0.1:8080/api/users/signup"
    static var currentUser:BSUser?
    
    static func isLogin()->Bool{
        return BSGlobal.currentUser != nil
    }
}

public struct BSStatus {
    static let OK:String = "OK"
}