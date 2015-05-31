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

    @IBAction func refreshClicked(sender: AnyObject)
    {
        latText.text = lhm.getLong()
        longText.text = lhm.getLat()
        distanceText.text = lhm.getDistance()
        
        
        /*let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            println("This is run on the background queue")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                println("This is run on the main queue, after the previous code in outer block")
            })
        })*/
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

