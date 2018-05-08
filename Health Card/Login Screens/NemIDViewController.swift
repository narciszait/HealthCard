//
//  NemIDViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 05/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class NemIDViewController: UIViewController, SlideButtonDelegate, URLSessionDelegate, URLSessionDataDelegate, UITextFieldDelegate {

    @IBOutlet weak var slideToLoginButton: MMSlidingButton!;
    @IBOutlet weak var nemdIDCodeTextField: DesignableUITextField!
    @IBOutlet weak var nemIdCodeToVerifyTextField: DesignableUITextField!
    
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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.navigationItem.leftBarButtonItem?.title = "";
        
        self.slideToLoginButton.delegate = self;
       
        loginSession = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main);
        if let nemdIDCodeIsPresent = nemIDChallenge{
            nemdIDCodeTextField.text = nemdIDCodeIsPresent;
        }
        
        nemIdCodeToVerifyTextField.text = "165240";
    }
    
    func buttonStatus(status: String, sender: MMSlidingButton) {
        if (status == "Unlocked"){
            UIView.animate(withDuration: 0.5, animations: {
                self.slideToLoginButton.alpha = 0.0;
            }) { (completed) in
                if (completed) {
                    //Here to make the call for the next screen
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true;
                    SVProgressHUD.show();
                    /*
                     the url has to be changed according to where the server is running
                     atm the nodejs server is running on my machine, which has the ip address (at my home network) of 192.168.0.100 and it running on port 8443
                     172.30.210.79
                     */
                    var request = URLRequest(url: URL(string: "https://pacific-reaches-57767.herokuapp.com/api/patient/2f")!); //172.30.210.79:8443/login
                    request.httpMethod = "POST";
                    request.setValue(("application/json"), forHTTPHeaderField: "Content-Type");
                    request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization");
                    let postBody = ["_cpr": self.cprNr!, "nemid_pas": self.nemIdCodeToVerifyTextField.text!];
                    request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: []);
                    
                    self.loginTask = self.loginSession.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print("error= \(String(describing: error))");
                            self.errorInConnection = true;
                            DispatchQueue.main.async {
                                self.showAlerts(title: "Error", message: "Error: \(error!.localizedDescription) \n Try again later.");
                                self.slideToLoginButton.alpha = 1.0;
                                self.slideToLoginButton.reset();
                                SVProgressHUD.dismiss();
                            }
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                            print ("status should be 200, but is \(httpStatus.statusCode)");
                            self.errorInHttpResponse = true;
                            DispatchQueue.main.async {
                                self.showAlerts(title: "Error", message: "Could not login. \n Check NemID Code");
                                self.slideToLoginButton.alpha = 1.0;
                                self.slideToLoginButton.reset();
                            }
                        } else {
                            if let returnedJSON = (try? JSON(data: data)) {
                                self.nextCall = returnedJSON["request"]["url"].stringValue;
                                
                                DispatchQueue.main.async {
                                    self.canContinueLoggingIn = true;
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                                    SVProgressHUD.dismiss();
                                    self.performSegue(withIdentifier: "showTheMain", sender: self);
                                }
                            }
                        }
                    }
                    self.loginTask.resume();
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTheMain" {
            let controller = segue.destination as! TabBarController
            controller.cprNr = self.cprNr;
            controller.token = self.token;
            controller.nextCall = self.nextCall;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    func showAlerts(title: String, message: String) {
        SVProgressHUD.dismiss();
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }

}
