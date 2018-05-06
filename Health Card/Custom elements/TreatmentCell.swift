//
//  TreatmentCell.swift
//  Health Card
//
//  Created by Narcis Zait on 02/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class TreatmentCell: UITableViewCell {

    @IBOutlet weak var medicationLabel: UILabel!;
    @IBOutlet weak var takeMedicationEveryLabel: UILabel!;
    @IBOutlet weak var endOfPeriodForMedicationLabel: UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
