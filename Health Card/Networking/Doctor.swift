//
//  Doctor.swift
//  Health Card
//
//  Created by Narcis Zait on 07/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class Doctor: Codable {
    let name: String?;
    let address: String?;
    let phone: String?;
//    let doctor_id: String?;
    
    init(name: String, address: String, phone: String){
        self.name = name;
        self.address = address;
        self.phone = phone;
    }
}
