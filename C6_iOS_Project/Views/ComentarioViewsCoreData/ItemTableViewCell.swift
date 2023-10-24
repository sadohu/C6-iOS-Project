//
//  ItemTableViewCell.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 24/10/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    //OUTLETS
    
    
    
    
    @IBOutlet weak var txtComentario: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
