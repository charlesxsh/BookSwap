//
//  BSError.swift
//  BookSwap
//
//  Created by Shihao Xia on 3/1/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BSError:CustomStringConvertible{
    var errorStr:String?
    
    init(_errorStr:String!)
    {
        self.errorStr = _errorStr
    }
    
    var description: String {
        return "[Error]:\(self.errorStr)"
    }
    
}

