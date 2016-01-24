//
//  TVCellForMeEmail.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class TVCellForMeEmail: UITableViewCell {
    
    @IBOutlet weak var lblEmail:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEmail(str:String){
        self.lblEmail.text = str
    }
}
