//
//  LoginViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 5/10/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtClave: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CustomConfig.configureViewController(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CustomConfig.restoreViewController(self)
    }
    //Actions
    @IBAction func btnNewUser(_ sender: UIButton) {
        performSegue(withIdentifier: "newUserView", sender: self)
    }//fin de btnNewUser
    
    @IBAction func btnIniciar(_ sender: UIButton) {
        //leer de las cajas txtUsuario y txtClave
               let login=txtUsuario.text ?? ""
               let pass=txtClave.text ?? ""
               //llamando a loginFirebase y le pasamos las 2 variables que almacenan el valor
               //de las cajas
               loginFirebase(usuario: login, clave: pass)
        
    }//fin de btnIniciar
    
    //creamos func o metodo que tiene de parametro usuario y clave de tipo string
        func loginFirebase(usuario:String,clave:String){
            //validar si el usuario(correo electronico) existe
            Auth.auth().signIn(withEmail: usuario, password: clave) { result, error in
                //validar result para saber si existe o no existe el usuario en firebase
                //data almacena lo de result si result tiene datos se ejecuta el if
                if let data = result{
                    print("LOGIN CORRECTO")
                    //imprimimos el valor desde firebase el email y codigo de registro
                    print(data.user.uid)
                    self.performSegue(withIdentifier: "loginMainSegue", sender: self);
                }//fin de if
                //si entra al else es que no tiene data
                else{
                    print("LOGIN INCORRECTO")
                }//fin de else
            } //fin de Auth
        }//fin de loginFirebase
}//fin de LogViewController
