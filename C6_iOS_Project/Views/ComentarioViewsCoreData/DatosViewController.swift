//
//  DatosViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 24/10/23.
//

import UIKit

class DatosViewController: UIViewController {

    
    
    //Outlets o referencias, esta DECLARADO mas no INICIALIZADO
    @IBOutlet weak var txtComent: UITextView!
    
    //Creamos variable de tipo dato ComentEntity hara match con lo de ComentarioViewController del prepare
        var bean:ComentEntity!
    
    override func viewDidLoad() {
        //Configurar ttextview
        txtComent.layer.borderWidth = 1.0
        txtComent.layer.cornerRadius = 5.0
        super.viewDidLoad()
        //Mostrar en las cajas apartir de bean
        txtComent.text=bean.comenta
    }//fin de viewDidLoad
    

    @IBAction func btnActualizar(_ sender: UIButton) {
              var coment:String
              //Leer de las cajas excepto codigo por que no se toca
              coment=txtComent.text ?? ""
              //llamamos al metodo seteamos con las variables de arriba
              bean.comenta=coment
              //invocar al metodo actualizarComentario
              ControladorComentario().actualizarComentario(bean: bean)
              print("Actualizado el COMENTARIO PAPU")
        
        
    }//fin de btnActualizar
    
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        
        //Crear ventana de alerta
         let ventana=UIAlertController(title: "SISTEMA", message: "Seguro de eliminar?", preferredStyle: .alert)
         //crear botonAceptar pasandole el bean de arriba por medio de self
        //var bean:ComentEntity!
        let botonAceptar=UIAlertAction(title: "Aceptar", style: .default,handler:{ action in ControladorComentario().eliminarComentario(bean: self.bean)
            print("ELIMINADO el COMENTARIO PAPU")
         })
         //agregamos el boton aceptar a la ventana
         ventana.addAction(botonAceptar)
         //boton de cancelar agregando a la ventana
         ventana.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
         //mostrar ventana con animacion true
         present(ventana, animated: true)
        
        
        
    }//fin de btnEliminar
    
   

}//fin de DatosViewController
