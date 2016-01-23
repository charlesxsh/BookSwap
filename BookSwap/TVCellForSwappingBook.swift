//
//  TVCellForSwappingBook.swift
//  BookSwap
//
//  Created by Charles Xia on 1/22/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class TVCellForSwappingBook: UITableViewCell {

    @IBOutlet weak var ImgViewBookImage: UIImageView!
    @IBOutlet weak var lBlBookName: UILabel!
    @IBOutlet weak var lBlEdition: UILabel!
    @IBOutlet weak var lBlAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBookImage(img:UIImage){
        self.ImgViewBookImage.image = img
    }
    
    func setBookName(str:String){
        self.lBlBookName.text = str
    }
    
    func setEdition(edition:Int){
        self.lBlEdition.text = "\(edition)"
    }
    
    func setAuthor(str:String){
        self.lBlAuthor.text = str
    }
    
    @IBAction func swapEvents(sender: AnyObject) {
    }
}
