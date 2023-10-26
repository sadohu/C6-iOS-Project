//
//  OptionsViewController.swift
//  C6_iOS_Project
//
//  Created by JeanPierre on 22/10/23.
//

//import UIkit
import UIKit
import FirebaseFirestore
class OptionsViewController: UIViewController {

    var tipoFormulario = -1;
    var tituloFormulario = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBuscoTrabajo(_ sender: UIButton) {
        tipoFormulario = 1
        tituloFormulario = "NECESITO UN EXPERTO PARA..."
        performSegue(withIdentifier: "formView", sender: self)
    }
    
    @IBAction func btnBrindoTrabajo(_ sender: UIButton) {
        tipoFormulario = 2
        tituloFormulario = "BRINDO SERVICIO EN..."
        performSegue(withIdentifier: "formView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "formView" {
            let view = segue.destination as! FormsViewController
            view.titulo = tituloFormulario;
            view.estado = tipoFormulario;
            
            
        }
    }
}
