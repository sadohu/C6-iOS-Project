//
//  LoginViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 5/10/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Oculta el navigationItem en este ViewController
        self.navigationItem.setHidesBackButton(true, animated: false) // Para ocultar el botón de retroceso
        self.navigationController?.navigationBar.isHidden = true // Para ocultar toda la barra de navegación (título y botones)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Asegúrate de restaurar la visibilidad del navigationItem cuando salgas de este ViewController
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.navigationController?.navigationBar.isHidden = false
    }
}
