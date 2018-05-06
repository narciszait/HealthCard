//
//  CardViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!;
    @IBOutlet weak var lastNameLabel: UILabel!;
    @IBOutlet weak var addressLabel: UILabel!;
    @IBOutlet weak var doctorNameLabel: UILabel!;
    @IBOutlet weak var doctorAddressLabel: UILabel!;
    @IBOutlet weak var doctorPhoneLabel: UILabel!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    
}
