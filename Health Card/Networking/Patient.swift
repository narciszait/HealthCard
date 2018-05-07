//
//  Patient.swift
//  Health Card
//
//  Created by Narcis Zait on 07/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class Patient: Codable {
//    let _id: String?;
    var cpr: String?;
//    let password: String?;
//    let patient_id: Int?;
    let address: String?;
    let firstName: String?;
    let lastName: String?;
//    let birthdate: String?;
//    let email: String?;
//    let mobile_phone: Int?;
//    let doctor: [Doctor]?;
//    let role: String?;
//    let role_id: String?;
//    let phone_no: String?;
//    let history: [History]?;
//    let underTreatment: String?;
//    let receipt: [Treatment]?;
    
    init(cpr: String, address: String, name: String, lastName: String) {
        self.cpr = cpr;
        self.address = address;
        self.firstName = name;
        self.lastName = lastName;
    }
}
