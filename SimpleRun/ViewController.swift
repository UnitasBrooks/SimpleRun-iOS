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
    


    @IBOutlet var avgSpeedTxt: UITextView!
    @IBOutlet var longLabel: UILabel!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var latText: UITextView!
    @IBOutlet var longText: UITextView!
    @IBOutlet var reloadButton: UIButton!
    @IBOutlet var distanceText: UITextView!
    var lhm = LocationHandlerModel()
    var running: Bool = false
    @IBAction func refreshClicked(sender: AnyObject) {
        var timer = NSTimer()
        running = !running
        if(lhm.toggleTracking()) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update:"), userInfo: nil, repeats: true)
            reloadButton.setTitle("Stop", forState: .Normal)
        } else {
            timer.invalidate()
            timer = nil
            reloadButton.setTitle("Start", forState: .Normal)
        }
    }
    
    /* Keeping this in as an example of how to work with threads, because I am bound to forget
    private func startRun() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
           
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //println("update the UI")
    
            })
        })
    }*/
    
    @objc func update(timer: NSTimer) {
        if(running){
            println("updating")
            self.lhm.incrementTime()
            self.latText.text = self.lhm.getLong()
            self.longText.text = self.lhm.getLat()
            self.distanceText.text = self.lhm.getDistance()
            self.avgSpeedTxt.text = self.lhm.getAvgSpeed()
        }
        
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

