//
//  PublicacionTableViewCell.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 23/10/23.
//

import UIKit

class PublicacionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTituloPubli: UILabel!
    
    
    @IBOutlet weak var lblDescripPubli: UILabel!
    
    
    @IBOutlet weak var lblNombrePer: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

} //fin de PublicacionTableViewCell
