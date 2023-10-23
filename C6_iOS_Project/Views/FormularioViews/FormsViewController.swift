//
//  FormsViewController.swift
//  C6_iOS_Project
//
//  Created by JeanPierre on 22/10/23.
//

import UIKit

class FormsViewController: UIViewController {

    @IBOutlet weak var lblTitulo: UILabel!
    
    var titulo: String = ""
    var estado: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitulo.text = titulo
        print(estado)
        // Do any additional setup after loading the view.
    }
    
    

}
