//
//  NemIDViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 05/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class NemIDViewController: UIViewController, SlideButtonDelegate {

    @IBOutlet weak var slideToLoginButton: MMSlidingButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.navigationItem.leftBarButtonItem?.title = "";
        
        self.slideToLoginButton.delegate = self;
    }
    
    func buttonStatus(status: String, sender: MMSlidingButton) {
        if (status == "Unlocked"){
            UIView.animate(withDuration: 0.5, animations: {
                self.slideToLoginButton.alpha = 0.0;
            }) { (completed) in
                if (completed) {
                    self.performSegue(withIdentifier: "showTheMain", sender: self);
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}