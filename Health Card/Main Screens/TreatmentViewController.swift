//
//  TreatmentViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class TreatmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var treatmentTableView: UITableView!;
    var receipts = [Treatment]();
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        treatmentTableView.tableFooterView = UIView();
        let tabBarController = self.tabBarController  as! TabBarController
        receipts = tabBarController.treatment;
    }

    @IBAction func renewSubscription(_ sender: Any) {
        let alertController = UIAlertController(title: "Renew subscription", message: "Would you like to renew your current subscription?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: nil);
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil);
        alertController.addAction(yesAction);
        alertController.addAction(noAction);
        self.present(alertController, animated: true, completion: nil);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipts.count;
        //        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = treatmentTableView.dequeueReusableCell(withIdentifier: "treatmentCell") as! TreatmentCell;
        cell.medicationLabel.text = receipts[indexPath.row].medication!
        cell.takeMedicationEveryLabel.text = receipts[indexPath.row].repeatInterval!;
        cell.endOfPeriodForMedicationLabel.text = receipts[indexPath.row].endPeriod!;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155;
    }

}
