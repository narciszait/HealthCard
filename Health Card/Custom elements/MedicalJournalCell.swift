//
//  MedicalJournalCell.swift
//  Health Card
//
//  Created by Narcis Zait on 02/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class MedicalJournalCell: UITableViewCell {

    @IBOutlet weak var medicalConditionLabel: UILabel!;
    @IBOutlet weak var periodOfTimeLabel: UILabel!;
    @IBOutlet weak var fullyRecoveredLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
