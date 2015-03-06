//
//  SessionViewController.swift
//  StandLonger
//
//  Created by 韦体东 on 15/2/24.
//  Copyright (c) 2015年 韦体东. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    
    @IBAction func switch2QA(sender: AnyObject) {
        var view = QAViewController()
        self.presentViewController(view, animated: true, completion: nil)
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