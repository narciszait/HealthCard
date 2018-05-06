//
//  PasswordViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 05/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cardImageView: UIImageView!;
    @IBOutlet weak var cardLabel: UILabel!;
    @IBOutlet weak var cprTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "nemIDSegue", sender: self);
        print("should next");
    }
    
}
