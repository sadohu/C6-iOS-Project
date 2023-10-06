//
//  NewUserViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 5/10/23.
//

import UIKit

class NewUserViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var switchTermsOfUse: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        configureMainGradientBackground();
    }
    
    @IBAction func btnNewUser(_ sender: UIButton) {
        
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
}
