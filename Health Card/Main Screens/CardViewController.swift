//
//  CardViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, URLSessionDelegate, URLSessionDataDelegate {

    @IBOutlet weak var firstNameLabel: UILabel!;
    @IBOutlet weak var lastNameLabel: UILabel!;
    @IBOutlet weak var addressLabel: UILabel!;
    @IBOutlet weak var doctorNameLabel: UILabel!;
    @IBOutlet weak var doctorAddressLabel: UILabel!;
    @IBOutlet weak var doctorPhoneLabel: UILabel!;
    @IBOutlet weak var cprTextField: DesignableUITextField!
    
    var cprNr: String?;
    var token: String?;
    var nextCall: String?;
    
    var loginSession: URLSession!;
    var loginTask: URLSessionTask!;
    
    var doctor: Doctor?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBarController = self.tabBarController  as! TabBarController;
        
        if let firstName = tabBarController.patient?.firstName {
            firstNameLabel.text = firstName;
        }
        
        if let lastName = tabBarController.patient?.lastName {
            lastNameLabel.text = lastName;
        }
        
        if let address = tabBarController.patient?.address {
            addressLabel.text = address;
        }
        
        if let doctoName = tabBarController.doctor?.name {
            doctorNameLabel.text = doctoName;
        }
        
        if let doctorAddress = tabBarController.doctor?.address {
            doctorAddressLabel.text = doctorAddress;
        }
        
        if let doctorPhone = tabBarController.doctor?.phone {
            doctorPhoneLabel.text = doctorPhone;
        }
        
        if let cprNr = tabBarController.patient?.cpr {
            cprTextField.text = cprNr;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
}
