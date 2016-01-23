//
//  TVCellForBooks.swift
//  BookSwap
//
//  Created by Charles Xia on 1/22/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class TVCellForBooks: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookOwner: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBookImageForCell(img:UIImage){
        self.bookImage.image = img
    }
    
    func setbookNameForCell(str:String){
        self.bookName.text = str
    }
    
    func setbookOwnerForCell(str:String){
        self.bookOwner.text = str
    }
    
}
