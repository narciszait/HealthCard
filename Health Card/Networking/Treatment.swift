//
//  Treatment.swift
//  Health Card
//
//  Created by Narcis Zait on 07/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class Treatment: Codable {
    let medication: String?;
    let repeatInterval: String?;
    let endPeriod: String?;
    
    init(medication: String, repeatInterval: String, endPeriod: String){
        self.medication = medication;
        self.repeatInterval = repeatInterval;
        self.endPeriod = endPeriod;
    }
}
