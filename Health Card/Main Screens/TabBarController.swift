//
//  TabBarController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var cprNr: String?;
    var token: String?;
    var nextCall: String?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("------ tabbar ------");
        print(self.cprNr, self.token, self.nextCall);
        print("------ tabbar ------");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
