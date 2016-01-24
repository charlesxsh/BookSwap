//
//  TVCellForPersonalInfo.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class TVCellForMe: UITableViewCell {

    @IBOutlet weak var ImgProfie: UIImageView!
    @IBOutlet weak var lblDisplayName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//          self.ImgProfie.layer.cornerRadius = self.ImgProfie.frame.width/2
//          self.ImgProfie.layer.masksToBounds = true

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProfie(img:UIImage){
        self.ImgProfie.image = img
    }
    
    func setDisplayName(str:String){
        self.lblDisplayName.text = str
    }
    
}
