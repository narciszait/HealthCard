//
//  VideoViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 15/03/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var backgroundPlayer: BackgroundVideo?;
    var blurEffect: UIBlurEffect?;
    var blurredEffectView: UIVisualEffectView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundPlayer = BackgroundVideo(on: self, withVideoURL: "videoDoctor.mp4"); //Telia.mov
        backgroundPlayer?.setUpBackground();
        
        self.blurEffect = UIBlurEffect(style: .dark);
        self.blurredEffectView = UIVisualEffectView(effect: self.blurEffect);
        self.blurredEffectView?.frame = (self.backgroundPlayer?.viewController?.view.bounds)!;
        self.blurredEffectView?.alpha = 0.5;
        self.view.addSubview(blurredEffectView!);
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
