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
    var illness = [History]();
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        medicalJournalTableView.tableFooterView = UIView();
        let tabBarController = self.tabBarController  as! TabBarController
        illness = tabBarController.history;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return illness.count;
        //        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medicalJournalTableView.dequeueReusableCell(withIdentifier: "medicalJournalCell") as! MedicalJournalCell;
        cell.medicalConditionLabel.text = illness[indexPath.row].diagnostic!;
        cell.periodOfTimeLabel.text = illness[indexPath.row].period;
        cell.fullyRecoveredLabel.text = illness[indexPath.row].status;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }


}
