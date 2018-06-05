//
//  InitialViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 05/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit
import JWT
import LocalAuthentication

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let tap = UITapGestureRecognizer(target: self, action: #selector(getPatientInfo));
        tap.numberOfTapsRequired = 2;
        self.view.addGestureRecognizer(tap);
    }
    
    @objc func getPatientInfo(){
        let string = JWT.encode(claims: ["":""], algorithm: .hs256("SecretKey".data(using: .utf8)!));
        print(string);
        self.performSegue(withIdentifier: "touchIDSegue", sender: self);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //self.performSegue(withIdentifier: "touchIDSegue", sender: self);
    @IBAction func loginAction(_ sender: Any) {
        if (UserDefaults.standard.bool(forKey: "firstLoginSuccessful")){
//            authenticateUserUsingTouchId()
            if (UserDefaults.standard.bool(forKey: "showedBiometricPrompt")){
                let laContext = LAContext();
                let touchIDAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil);
                
                if touchIDAvailable {
                    laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate") { (authenticated, error) in
                        if authenticated {
                            DispatchQueue.main.async{
                                self.performSegue(withIdentifier: "touchIDSegue", sender: self);
                            }
                            
                        } else {
                            print(error?.localizedDescription);
                            let laError = error as! LAError;
                            if laError.code == .userFallback {
                                print("fallback");
                                DispatchQueue.main.async{
                                    self.performSegue(withIdentifier: "showPasswordScreenSegue", sender: self);
                                }
                                
                            }
                            if laError.code == .userCancel {
                                print("cancel");
                                DispatchQueue.main.async{
                                    self.performSegue(withIdentifier: "showPasswordScreenSegue", sender: self);
                                }
                            }
                            if laError.code == .authenticationFailed {
                                print("failed");
                                DispatchQueue.main.async{
                                    self.performSegue(withIdentifier: "showPasswordScreenSegue", sender: self);
                                }
                            }
                        }
                    }
                } else {
                    print("no touch id");
                    self.performSegue(withIdentifier: "showPasswordScreenSegue", sender: self);
                }
            }
            else {
                self.performSegue(withIdentifier: "showPasswordScreenSegue", sender: self);
            }
        }
        else {
            self.performSegue(withIdentifier: "showPasswordScreenSegue", sender: self);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "touchIDSegue" {
            let controller = segue.destination as! TabBarController
            controller.cprNr = UserDefaults.standard.value(forKey: "citizenCPR") as? String;
            controller.token = JWT.encode(claims: ["":""], algorithm: .hs256("SecretKey".data(using: .utf8)!));
            print("moving to main");
        }
    }
    
    @IBAction func segueToMe(segue: UIStoryboardSegue) {
        // segue back
        print("back to Main");
        UserDefaults.standard.set(false, forKey: "firstLoginSuccessful");
        UserDefaults.standard.set("", forKey: "citizenCPR");
    }
    
//    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
//        if let id = identifier {
//            if id == "returnToMainViewController" {
//                let unwindSegue = UIStoryboardUnwindSegueFromRight(identifier: id, source: fromViewController, destination: toViewController)
//                return unwindSegue
//            }
//        }
//        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)!
//    }
}
