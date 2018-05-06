//
//  MedicalJournalViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class MedicalJournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var medicalJournalTableView: UITableView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        medicalJournalTableView.tableFooterView = UIView();
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medicalJournalTableView.dequeueReusableCell(withIdentifier: "medicalJournalCell") as! MedicalJournalCell;
        cell.medicalConditionLabel.text = "Influenza";
        cell.periodOfTimeLabel.text = "2 weeks";
        cell.fullyRecoveredLabel.text = "Yes";
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }


}
