//
//  TabBarController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, URLSessionDelegate, URLSessionDataDelegate {
    
    var cprNr: String?;
    var cprNrFromUserDefaults: String?
    var token: String?;
    var nextCall: String?;
    var patient: Patient?;
    var doctor: Doctor?;
    var history: [History] = [];
    var treatment: [Treatment] = [];
    
    var loginSession: URLSession!;
    var loginTask: URLSessionTask!;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cprNrFromUserDefaults = UserDefaults.standard.value(forKey: "citizenCPR") as? String;
        loginSession = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main);
        getPatientInfo();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.view.setNeedsLayout();
        
        if (UserDefaults.standard.bool(forKey: "firstLoginSuccessful")) {
            if (!UserDefaults.standard.bool(forKey: "showedBiometricPrompt")) {
                let alert = UIAlertController(title: "Use biometric?", message: "Do you want to use your phone's biometrics to login next time? \n You can use the biometric login until you log out of the application", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
                    print("Yes to biometric");
                    UserDefaults.standard.set(true, forKey: "firstLoginSuccessful");
                    UserDefaults.standard.set(true, forKey: "showedBiometricPrompt");
                }));
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                    print("No to biometric");
                    UserDefaults.standard.set(false, forKey: "firstLoginSuccessful");
                }))
                
                self.present(alert, animated: true);
            }
        }
    }
    
    func getPatientInfo(){
        print("TabBarController getting Patient Info");
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        SVProgressHUD.show();
        /*
         the url has to be changed according to where the server is running
         atm the nodejs server is running on my machine, which has the ip address (at my home network) of 192.168.0.100 and it running on port 8443
         172.30.210.79
         */
        var cpr: String;
        if (cprNr != nil) {
            cpr = cprNr!;
        } else {
            cpr = cprNrFromUserDefaults!;
        }
//        if let cpr = cprNr  {
            var request = URLRequest(url: URL(string: "https://pacific-reaches-57767.herokuapp.com/api/patient/\(cpr)")!); //localhost:3000/api/patient/cprNr
            request.httpMethod = "GET";
            request.setValue(("application/json"), forHTTPHeaderField: "Content-Type");
            request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization");
            print("request to \(request) + \(self.token)");
            print("1");
            
            loginTask = loginSession.dataTask(with: request, completionHandler: { (data, response, error) in
                print("1.5");
                guard let data = data, error == nil else {
                    print("error= \(String(describing: error))");
                    DispatchQueue.main.async {
                        self.showAlerts(title: "Error", message: "Error: \(error!.localizedDescription) \n Try again later.");
                        SVProgressHUD.dismiss();
                    }
                    return
                };
                print("2");
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 401 {
                    print ("status should be 200, but is \(httpStatus.statusCode)");
                    DispatchQueue.main.async {
                        self.showAlerts(title: "Error", message: "Could not get user data. \n Try again later");
                    }
                } else {
                    print("3");
                    if let returnedJSON = (try? JSON(data: data)) {
                        print(returnedJSON);
                        self.doctor = Doctor(name: returnedJSON["doctor"]["name"].string!, address: returnedJSON["doctor"]["address"].string!, phone: returnedJSON["doctor"]["phone"].string!);
                        print(self.doctor);
                        self.patient = Patient(cpr: returnedJSON["_cpr"].stringValue, address: returnedJSON["address"].string!, name: returnedJSON["name"].string!, lastName: returnedJSON["last_name"].string!);
                        print(self.patient);

                        for (index,subJson):(String, JSON) in returnedJSON["history"] {
                            self.history.append(History(diagnostic: subJson["diagnostic"].string!, period: subJson["period"].string!, status: subJson["status"].string!));
                        }

                        for (index,subJson):(String, JSON) in returnedJSON["receipt"] {
                            self.treatment.append(Treatment(medication: subJson["medication"].string!, repeatInterval: subJson["repeat"].string!, endPeriod: subJson["endperiod"].string!));
                        }

                        DispatchQueue.main.async {
                            self.view.setNeedsLayout();
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            SVProgressHUD.dismiss();
                        }
                    }
                }
            });
            loginTask.resume();
//        }
        
    }
    
    func showAlerts(title: String, message: String) {
        SVProgressHUD.dismiss();
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
