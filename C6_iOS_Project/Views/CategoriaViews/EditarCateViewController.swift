//
//  EditarCateViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 21/10/23.
//

import UIKit

class EditarCateViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtCodigo: UITextField!
    
    
    @IBOutlet weak var txtNombre: UITextField!
    
    
    @IBOutlet weak var txtTipo: UITextField!
    
    @IBOutlet weak var txtImagen: UITextView!
    
    //creamos atributo medi Ae tipo MediAamento que As struct
        var categ:Categoria!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Obtenemos de medi los Aampos y mostramos en las cajas txt
               txtCodigo.text=String(categ.id)
               txtNombre.text=categ.nombre
               txtTipo.text=categ.tipo
               txtImagen.text=categ.imagen

    } //fin de viewDidLoad
    

    @IBAction func btnModificar(_ sender: UIButton) {
        //leermos lo de las cajas para eso creamos variables para coger la data de las cajas
                var cod:Int
               var nom,tipo,imagen:String
               //asociamos las cajas con las variables
               cod = Int(txtCodigo.text ?? "0") ?? 0
               nom=txtNombre.text ?? ""
               tipo=txtTipo.text ?? ""
               imagen=txtImagen.text ?? ""
              
               //variable de tipo Medicamento struct
               let cat = Categoria(id: cod, nombre: nom, tipo: tipo, imagen: imagen)
               //llamamos a grabarMedicamento de abajo y le pasamos med
               modificarCategoria(bean: cat)
               print("Categoria Actualizada")
        
        
    }//fin de btnModificar
    
    
    
    @IBAction func btnEliminar(_ sender: UIButton) {
        //ALERTA
            //Crear ventana de alerta
            let ventana=UIAlertController(title: "SISTEMA", message: "Seguro de eliminar?", preferredStyle: .alert)
            //crear botonAceptar pasandole el bean de arriba por medio de self
            let botonAceptar=UIAlertAction(title: "Aceptar", style: .default,handler:{ action in //leermos lo de las cajas para eso creamos variables para coger la data de las cajas
                let cod:Int
                //asociamos las cajas con las variables
                cod = Int(self.txtCodigo.text ?? "0") ?? 0
                //llamamos Al metodo eliminar de abajo
                self.eliminar(cod: cod)
            })
            //agregamos el boton aceptar a la ventana
            ventana.addAction(botonAceptar)
            //boton de cancelar agregando a la ventana
            ventana.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            //mostrar ventana con animacion true
            present(ventana, animated: true)
    }//fin de btnEliminar
    
    //creamos funcionar para grabar donde de parametro es bean de tipo Medicamento struct
       func modificarCategoria(bean:Categoria){
           //ponemos do catch para controlar excepciones
           do{
               //convertir a JSON el valor del parametro bean PARA SERIALIZAR JSON ENCODER
               let jsonData = try JSONEncoder().encode(bean)
               //almacenamos la URL de la API en una variable URLAPI
               let URLAPI="https://9e44-45-5-69-231.ngrok-free.app/categoria/actualizar"
               //convertimos a URL la variable URLAPI
               let urlRegistrar=URL(string: URLAPI)
               //creamos variable request que almacena un URLRequest y le pasamos en parametro
               //el urlRegistrar creado arriba,ponemos ! para decirle que si TENDRA DATOS Asegurando
               var request = URLRequest(url: urlRegistrar!)
               //especificar parametros es decir si es PUT DELETE POST
               request.httpMethod = "PUT"
               //especificar que request es un JSON ,se va a enviar un JSON
               //ponemos en parametros application/json y Content Type
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               //respuesta del servicio sea JSON por eso el Accept
               request.setValue("application/json", forHTTPHeaderField: "Accept")
               //envio de JSON
               request.httpBody = jsonData
               //crear tarea
               //Con URLSession le pasamos el request de arriba
               //parametro data almacena la respuesta del JSON , la respuesta de confirmacion 201 Created
               //lo almacena response, parametro error para capturar el error por si hubiese
               //al poner in debajo de ello ira una logica
               let tarea=URLSession.shared.dataTask(with: request){data,response,error in
                   //para controlar con do
                   do{
                       //si error es nulo osea todo bien
                       if error==nil{
                           //variable datos almacena la DESERIALIZACION de Medicamento
                           // de parametro data que tiene la respuesta JSON
                           let datos = try JSONDecoder().decode(Categoria.self, from: data!)
                           //imprime datos cuando lo ingresa
                           print(datos)
                       }//fin de if
                   }//fin de segundo do
                   catch{
                       print(error.localizedDescription)
                   }//fin de catch
                   
               }//fin de URL SESSION
               //Iniciar tarea (el resume) es para que ejecute todo el codigo de arriba
               tarea.resume()
           }//fin del primer do
           catch{
               print("Error")
           }//fin de catch
       }//fin de grabarMedicamento
    
    //Func para eliminar donde lo llamaremos dentro Ae btnEliminar
        func eliminar(cod:Int){
            
            //almacenamos la URL de la API en una variable URLAPI
            let URLAPI="https://9e44-45-5-69-231.ngrok-free.app/categoria/eliminar/"+String(cod)
            //convertimos a URL la variable URLAPI
            let urlEliminar=URL(string: URLAPI)
            //creamos variable request que almacena un URLRequest y le pasamos en parametro
            //el urlRegistrar creado arriba,ponemos ! para decirle que si TENDRA DATOS Asegurando
            var request = URLRequest(url: urlEliminar!)
            //especificar parametros es decir si es PUT DELETE POST
            request.httpMethod = "DELETE"
            //crear tarea
            //Con URLSession le pasamos el request de arriba
            //parametro data almacena la respuesta del JSON , la respuesta de confirmacion 204 No contenido
            //lo almacena response, parametro error para capturar el error por si hubiese
            //al poner in debajo de ello ira una logica
            let tarea=URLSession.shared.dataTask(with: request){data,response,error in
                //para controlar con do
              
                    //si error es nulo osea todo bien
                    if error==nil{
                        print("ELIMINADO")
                    }//fin de if
            }//fin de URL SESSION
            //Iniciar tarea (el resume) es para que ejecute todo el codigo de arriba
            tarea.resume()
        }//fin Ae eliminar
    
    

}//fin de EditarCateViewController
