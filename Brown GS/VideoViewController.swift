//
//  VideoViewController.swift
//  Brown GS
//
//  Created by Jillian Turner on 6/29/18.
//  Copyright © 2018 Jillian Turner. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //lockOrientation(UIInterfaceOrientationMask.landscapeRight)

        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
     func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
