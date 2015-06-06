//
//  ViewController.swift
//  SimpleRun
//
//  Created by Joe Yuhas on 5/24/15.
//  Copyright (c) 2015 Joe Yuhas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    @IBOutlet var longLabel: UILabel!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var latText: UITextView!
    @IBOutlet var longText: UITextView!
    @IBOutlet var reloadButton: UIButton!
    @IBOutlet var distanceText: UITextView!
    var lhm = LocationHandlerModel()
    let queue = NSOperationQueue()
    var onOff = false
    
    @IBAction func refreshClicked(sender: AnyObject)
    {
        latText.text = lhm.getLong()
        longText.text = lhm.getLat()
        distanceText.text = lhm.getDistance()
        
        onOff = !onOff
        if(!onOff) {
            println("here")
            queue.suspended = true
        }
        
        
        queue.addOperationWithBlock() {
            while(self.onOff) {
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.latText.text = self.lhm.getLong()
                    self.longText.text = self.lhm.getLat()
                    self.distanceText.text = self.lhm.getDistance()
                }
            }
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

