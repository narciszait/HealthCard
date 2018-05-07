//
//  History.swift
//  Health Card
//
//  Created by Narcis Zait on 07/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class History: Any {
    let diagnostic: String?;
    let period: String?;
    let status: String?;
    
    init(diagnostic: String, period: String, status: String){
        self.diagnostic = diagnostic;
        self.period = period;
        self.status = status;
    }
}
