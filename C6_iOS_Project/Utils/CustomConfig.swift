//
//  CustomConfig.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 5/10/23.
//

import UIKit

class CustomConfig {
    
    static func configureViewController(_ viewController: UIViewController) {
        // Oculta el navigationItem en este ViewController
        viewController.navigationItem.setHidesBackButton(true, animated: false); // Para ocultar el botón de retroceso
        viewController.navigationController?.navigationBar.isHidden = true; // Para ocultar toda la barra de navegación (título y botones)
   }
   
   static func restoreViewController(_ viewController: UIViewController) {
       // Asegúrate de restaurar la visibilidad del navigationItem cuando salgas de este ViewController
       viewController.navigationItem.setHidesBackButton(false, animated: false);
       viewController.navigationController?.navigationBar.isHidden = false;
   }
}
