//
//  Patient.swift
//  Health Card
//
//  Created by Narcis Zait on 07/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class Patient: Codable {
    var cpr: String?;
    let address: String?;
    let firstName: String?;
    let lastName: String?;
    
    init(cpr: String, address: String, name: String, lastName: String) {
        self.cpr = cpr;
        self.address = address;
        self.firstName = name;
        self.lastName = lastName;
    }
}
