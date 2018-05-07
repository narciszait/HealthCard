//
//  Server Connection.swift
//  Health Card
//
//  Created by Narcis Zait on 06/05/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import Foundation

class NetworkConnection: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    static let shared = NetworkConnection();
    
    let baseServerAddress = "http://192.168.100.173:3000/api/patient/";
    let contentTypeHeader = ["Content-Type":"application/json"];
    var tokenFromServer = "";
    var tokenHeader = ["Authorization": "Bearer "];
    
    var urlSession: URLSession!;
    var urlSessionTask: URLSessionTask!;
    
    func loginCall(cpr: String, password: String){
        print("loginCall 1");
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main);
        
        var request = URLRequest(url: URL(string: "https://172.20.10.3:8443/login")!); //172.30.210.79:8443/login
        request.httpMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        let postBody = ["_cpr":cpr, "password":password];
        request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: []);
        print("loginCall 2");
        urlSessionTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            print("loginCall 3");
            print("data \(String(describing: data))");
            print("response \(String(describing: response))");
            print("error \(String(describing: error?.localizedDescription))");
            print("loginCall 4");
        })
        print("loginCall 5");
        urlSessionTask.resume();
        print("loginCall 6");
        
//        return "make call loginCall";
    }
    
    func continueLoginWith2f(cpr: String, nemIdCode: String) -> String {
        
        return "make call to continueLoginWith2f";
    }
    
    func getPatientDetails(cpr: String) -> String {
        return "make call to getPatientDetails";
    }
}
