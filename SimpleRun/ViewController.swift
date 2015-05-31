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
    var lhm = LocationHandlerModel()

    @IBAction func refreshClicked(sender: AnyObject) {
        latText.text = lhm.getLong()
        longText.text = lhm.getLat()
        print("here")
        
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

