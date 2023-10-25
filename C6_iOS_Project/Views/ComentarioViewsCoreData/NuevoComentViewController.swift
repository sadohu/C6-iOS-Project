//
//  NuevoComentViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 24/10/23.
//

import UIKit

class NuevoComentViewController: UIViewController {
    //Obtengo uid
    var u:String!
    
    //Outlet
    @IBOutlet weak var txtComentario: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configurar ttextview
        txtComentario.layer.borderWidth = 1.0
        txtComentario.layer.cornerRadius = 5.0
   
    }//fin de viewDidLoad
    
    //btn guardar comentario es
    @IBAction func btnNuevo(_ sender: UIButton) {
        //Declaramos variable para poder almacena lo de las cajas
        var com,coduid:String
        //Leer de las cajas
        coduid=self.u
        com=txtComentario.text ?? ""
        //crear variable de la structura Comentario
        let data = Comentario(uid: coduid, comenta: com)
        //invocar al metodo registraComentario
        ControladorComentario().registrarComentario(bean: data)
        //print
        print("GUARDADO CORRECTAMENTE")
    }//fin de btnNuevo o guardar comentario
}//fin de NuevoComentViewController
