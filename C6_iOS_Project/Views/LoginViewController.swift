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
        CustomConfig.configureViewController(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CustomConfig.restoreViewController(self)
    }
    @IBAction func btnNewUser(_ sender: UIButton) {
        performSegue(withIdentifier: "newUserView", sender: self)
    }
}
