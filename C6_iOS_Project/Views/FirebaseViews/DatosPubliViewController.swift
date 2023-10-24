//
//  DatosPubliViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 23/10/23.
//

import UIKit
//Importamos
import FirebaseFirestore
class DatosPubliViewController: UIViewController {
   //OUTLETS
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblPublicaPer: UILabel!
    
    @IBOutlet weak var txtDescripPer: UITextView!
    @IBOutlet weak var txtComentario: UITextView!
    //creamos atributo data de tipo Publicacion que es struct
    //obteniendo lo de PublicViewController es decir los datos cuando le de click
       var data:Publicacion!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configurar ttextview
        txtComentario.layer.borderWidth = 1.0
        txtComentario.layer.cornerRadius = 5.0
        //Mostrar data en label u caja
        lblTitulo.text=String(data.titulopubli)
        lblPublicaPer.text=String(data.nombrepublicaper)
        //lblDescripPer.text=String(data.descrippublicaper)
        txtDescripPer.text=data.descrippublicaper
        txtComentario.text=data.comentinteres
       
    }//fin de viewDidLoad
    //Este boton actualiza en realidad
    @IBAction func btnContactar(_ sender: UIButton) {
        
        //Almacenamos en variable lo de las caja
               let comentario=txtComentario.text ?? ""
                
        //BD para acceder en firestore
        let BD = Firestore.firestore()
        //accedemos a coleccion, pasamos el uid que es como PK con setData modificado
               BD.collection("publicacion").document(data.uid).setData([
                //al que tiene  de nombre comentinteres con la variable comentario
                "titulopubli":data.titulopubli,
                "comentinteres":comentario,
                "nombrepublicaper":data.nombrepublicaper,
                "descrippublicaper":data.descrippublicaper,
                "descrippubli":data.descrippubli,
                "idCategoria":data.idCategoria,
                "tipo":data.tipo
               ]){ error in
                   //validamos con la variable error de arriba , por si sale error
                   //si ex= error es true osea hay error
                   if let ex=error{
                       self.ventanaMensaje(men: "Error en la actualización de Publicacion")
                   }//fin de if
                   //al else cuando no hay ningun tipo de error
                   else{
                       self.ventanaMensaje(men: "El contacto ha sido correcto")
                   }
               } //fin de error in
        
        //si hubiera boton eliminar hariamos esto
        //---------PARA ELIMINAR-----
       /* let BD = Firestore.firestore()
        //al colecction de publicacion pasamos uid por medio de data y ponemos delete
              BD.collection("publicacion").document(data.uid).delete()
               { error in
                   //validamos con la variable error de arriba , por si sale error
                   //si ex= error es true osea hay error
                   if let ex=error{
                       self.ventanaMensaje(men: "Error en la eliminación de Publicacion")
                   }//fin de if
                   //al else cuando no hay ningun tipo de error
                   else{
                       self.ventanaMensaje(men: "Registro eliminado correctamente")
                   }
               } //fin de error in
        //-----------------------------
        */
    }//fin de btnContactar
    
    //si hubiera boton eliminar hariamos esto
    //---------PARA ELIMINAR-----
   /* let BD = Firestore.firestore()
    //al colecction de publicacion pasamos uid por medio de data y ponemos delete
          BD.collection("publicacion").document(data.uid).delete()
           { error in
               //validamos con la variable error de arriba , por si sale error
               //si ex= error es true osea hay error
               if let ex=error{
                   self.ventanaMensaje(men: "Error en la eliminación de Publicacion")
               }//fin de if
               //al else cuando no hay ningun tipo de error
               else{
                   self.ventanaMensaje(men: "Registro eliminado correctamente")
               }
           } //fin de error in
    //-----------------------------
    */
      //creamos funcion para mensaje
      func ventanaMensaje(men:String){
          //ALERTA
          //Crear ventana de alerta
          let ventana=UIAlertController(title: "SISTEMA", message: men, preferredStyle: .alert)
          ventana.addAction(UIAlertAction(title: "Aceptar", style: .default))
          //con esto activamos la ventana
          present(ventana, animated: true)
          
      }//fin de ventanaMensaje
}//fin de DatosPublicViewController
