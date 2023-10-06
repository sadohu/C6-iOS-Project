//
//  ViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 4/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        configureMainGradientBackground();
    }

    @IBAction func btnStart(_ sender: UIButton) {
        performSegue(withIdentifier: "loginView", sender: self);
        
    }
    
    func configureMainGradientBackground() {
        let gradientLayer = CAGradientLayer();
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(named: "mainGreen")!.cgColor,
            UIColor(named: "mainGreen")!.cgColor
        ];
        gradientLayer.locations = [0.44, 0.85, 1];
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5);
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5);
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1.01, c: -1.01, d: 0, tx: 1.01, ty: 0));
        gradientLayer.bounds = view.bounds.insetBy(dx: -0.5 * view.bounds.size.width, dy: -0.5 * view.bounds.size.height);
        gradientLayer.position = view.center;
        view.layer.insertSublayer(gradientLayer, at: 0);
    }
    
}

