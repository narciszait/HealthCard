//
//  PasswordViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 05/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate, URLSessionDelegate, URLSessionDataDelegate {
    
    @IBOutlet weak var cprTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    
    var errorInConnection = false;
    var errorInHttpResponse = false;
    var errorInUsernameAndPassword = false;
    var canContinueLoggingIn = false;
    var loginSession: URLSession!;
    var loginTask: URLSessionTask!;
    
    var cprNr: String?;
    var nemIDChallenge: String?;
    var token: String?;
    var nextCall: String?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBar.isHidden = false;
        
        cprTextField.text = "1234567890";
        passwordTextField.text = "pass";
        
        loginSession = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main);
    } 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    self.performSegue(withIdentifier: "nemIDSegue", sender: self);
    @IBAction func loginAction(_ sender: Any) {
        if (cprTextField.text! == "" || passwordTextField.text! == "") {
            self.showAlerts(title: "Error", message: "Username and/or password cannot be empty");
        }
        else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
            SVProgressHUD.show();
            /*
             the url has to be changed according to where the server is running
             atm the nodejs server is running on my machine, which has the ip address (at my home network) of 192.168.0.100 and it running on port 8443
             172.30.210.79
             */
            // https://pacific-reaches-57767.herokuapp.com/api/ http://localhost:3000/api/patient/login
            var request = URLRequest(url: URL(string: "https://pacific-reaches-57767.herokuapp.com/api/login")!); //172.30.210.79:8443/login
            request.httpMethod = "POST";
            request.setValue(("application/json"), forHTTPHeaderField: "Content-Type");
            let postBody = ["_cpr": cprTextField.text!, "password": passwordTextField.text!];
            request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: []);
            
            
            loginTask = loginSession.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("error= \(String(describing: error))");
                    self.errorInConnection = true;
                    DispatchQueue.main.async {
                        self.showAlerts(title: "Error", message: "Error: \(error!.localizedDescription) \n Try again later.");
                        SVProgressHUD.dismiss();
                    }
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                    print ("status should be 200, but is \(httpStatus.statusCode)");
                    self.errorInHttpResponse = true;
                    DispatchQueue.main.async {
                        self.showAlerts(title: "Error", message: "Could not login. \n Check username and password");
//                        SVProgressHUD.dismiss();
                    }
                } else {
                    if let returnedJSON = (try? JSON(data: data)) {
                        self.cprNr = returnedJSON["cpr"].stringValue;
                        self.nemIDChallenge = returnedJSON["nemid"].stringValue;
                        self.token = returnedJSON["token"].stringValue;
                        self.nextCall = returnedJSON["request"]["url"].stringValue;
                        
                        DispatchQueue.main.async {
                            self.canContinueLoggingIn = true;
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            SVProgressHUD.dismiss();
                            self.performSegue(withIdentifier: "nemIDSegue", sender: self);
                        }
                    }
                }
            }
            self.loginTask.resume();
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nemIDSegue" {
                let controller = segue.destination as! NemIDViewController
                controller.cprNr = self.cprNr;
                controller.nemIDChallenge = self.nemIDChallenge;
                controller.token = self.token;
                controller.nextCall = self.nextCall;
            }
    }
    
    func showAlerts(title: String, message: String) {
        SVProgressHUD.dismiss();
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
}

//                    let jsonSwifty = try? JSON(data:data);
//                    print(jsonSwifty!);
////                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any];
//                    print(jsonSwifty!["request"]["url"]);
//
//                    self.cprNr = jsonSwifty!["cpr"].stringValue;
//                    self.nemIDChallenge = jsonSwifty!["nemid"].stringValue;
//                    self.token = jsonSwifty!["token"].stringValue;
////                    let nextCall = try? JSONSerialization.jsonObject(with: json!["request"]!, options: []) as! [String: Any];
////                    self.next =
