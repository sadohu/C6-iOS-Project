//
//  NewUserViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 5/10/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class NewUserViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var switchTermsOfUse: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        configureMainGradientBackground();
    }
    
    @IBAction func btnNewUser(_ sender: UIButton) {
        //Almacenamos en variable lo de las cajas
        let nomCom=txtName.text ?? ""
        let edad=Int(txtEdad.text ?? "0") ?? 0
        let email=txtEmail.text ?? ""
        let pass=txtPassword.text ?? ""
        //llamamos al metodo de abajo
        registrar(nombreCompleto: nomCom, edad: edad, correo: email, clave: pass)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func configureMainGradientBackground(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
        UIColor(red: 0.667, green: 0.817, blue: 0.817, alpha: 1).cgColor,
        UIColor(red: 0.464, green: 0.555, blue: 0.691, alpha: 1).cgColor,
        UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 0.12, 0.30]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        gradientLayer.position = view.center
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //creamos funcion o metodo(registrar) para grabar, le enviamos nombrecompleto, edad,email y clave
    //para luego obtener la autenticacion UID pasandole otro metodo
    func registrar(nombreCompleto:String,edad:Int,correo:String,clave:String){
        if(switchTermsOfUse.isOn){
            //Grabar la autenticacion, en withEmail le pasamos el parametro correo y en password clave
            Auth.auth().createUser(withEmail: correo, password: clave){ result,error in
            //data almacena lo de result , osea si esto es correcto result tiene datos y almacenado en data
                if let data=result{
                    //retorna UID de la autenticacion registrada y lo almacenamos en el uid
                    let uid=data.user.uid
                    //llamamos a registrarUsuario pasandole lo demas adicionando el uid
                    self.registrarUsuario(nombreC: nombreCompleto, edad: edad, uid: uid)
                }//fin de if
                else{
                    //si hubiese error llamados al metodo de ventanamensaje con self y le
                    //pasamos el mensaje
                    self.ventanaMensaje(men: "Error en el registro de la autenticacion")
                }//fin de else
            }//fin de Auth
        }else{
            self.ventanaMensaje(men: "Acepte los terminos y condiciones.")
        }
    }//fin de registrarAutenticacion
    
    //creamos metodo para grabar en firestore database pasandole de parametros
    //nombre,apellido,edad y el uid generado
    func registrarUsuario(nombreC:String,edad:Int,uid:String){
       //grabar usuario en firestore database
       //obtener acceso a la base de datos
       let BD = Firestore.firestore()
       //acceder a la tabla o coleccion llamada usuarios
       //y en documennt le pasamos el uid
       BD.collection("usuarios").document(uid).setData([
           "nombrecompleto":nombreC,
           "edad":edad
       ]){ error in
           //validamos con la variable error de arriba , por si sale error
           //si ex= error es true osea hay error
           if let ex=error{
               self.ventanaMensaje(men: "Error en el registro de usuario y credenciales")
           }//fin de if
           //al else cuando no hay ningun tipo de error
           else{
               self.ventanaMensaje(men: "Registro de usuario y crendenciales correctas")
           }
       } //fin de error in
    }//fin de registrarUsuario
    
    //creamos funcion para mensaje
    func ventanaMensaje(men:String){
      //ALERTA
      //Crear ventana de alerta
      let ventana=UIAlertController(title: "SISTEMA", message: men, preferredStyle: .alert)
      ventana.addAction(UIAlertAction(title: "Aceptar", style: .default))
      //con esto activamos la ventana
      present(ventana, animated: true)
    }//fin de ventanaMensaje
}
