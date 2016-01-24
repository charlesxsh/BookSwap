



//
//  TVCellForRequestBook.swift
//  BookSwap
//
//  Created by Charles Xia on 1/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class TVCellForRequestBook: UITableViewCell {

    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblEdition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBookName(str:String){
        self.lblBookName.text = str
    }
    
    func setBookAuthor(str:String){
        self.lblAuthorName.text = "Author(s):\(str)"
    }
    
    func setBookEdition(edition:Int){
        self.lblEdition.text = "Edition:\(edition)"
    }
    
}
