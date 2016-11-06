//
//  ViewController.swift
//  ActivityNavigationBar
//
//  Created by Pete Smith on 11/03/2016.
//  Copyright (c) 2016 Pete Smith. All rights reserved.
//

import UIKit
import ActivityNavigationBar

class ViewController: UIViewController {
    
    @IBOutlet weak var durationTextField: UITextField!
    
    var duration: Double {
        guard let enteredDuration = durationTextField.text,
            let duration = Double(enteredDuration) else { return 1 }
        
        return duration
    }
    
    private var activityNavigationBar: ActivityNavigationBar? {
        guard let activityNavigationBar = navigationController?.navigationBar as? ActivityNavigationBar else { return nil }
        
        return activityNavigationBar
    }
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        
        activityNavigationBar?.startActivity(andWaitAt: 0.8)
    }
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        activityNavigationBar?.finishActivity(withDuration: duration)
    }
    
    
    @IBAction func resetButtonPressed(sender: AnyObject) {
        activityNavigationBar?.reset()
    }
}

