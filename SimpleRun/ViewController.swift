//
//  ViewController.swift
//  SimpleRun
//
//  Created by Joe Yuhas on 5/24/15.
//  Copyright (c) 2015 Joe Yuhas. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    


    @IBOutlet var longLabel: UILabel!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var latText: UITextView!
    @IBOutlet var longText: UITextView!
    @IBOutlet var reloadButton: UIButton!
    @IBOutlet var distanceText: UITextView!
    var lhm = LocationHandlerModel()
    var onOff = false
    var runInProgress = NSOperation()

    
    @IBAction func refreshClicked(sender: AnyObject)
    {
        latText.text = lhm.getLong()
        longText.text = lhm.getLat()
        distanceText.text = lhm.getDistance()
        onOff = !onOff
        if(onOff) {
            startRun()
            reloadButton.setTitle("Stop", forState: .Normal)
        } else {
            reloadButton.setTitle("Start", forState: .Normal)
        }
        
    }
    
    private func startRun() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            while(self.onOff) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //println("update the UI")
                    self.latText.text = self.lhm.getLong()
                    self.longText.text = self.lhm.getLat()
                    self.distanceText.text = self.lhm.getDistance()
                })
                sleep(1)
            }
        })
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

