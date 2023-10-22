//
//  MyTableViewCell.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 21/10/23.
//

import UIKit

class MTableViewCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
