//
//  ViewController.swift
//  StandLonger
//
//  Created by 韦体东 on 15/2/24.
//  Copyright (c) 2015年 韦体东. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blinkImageView: UIImageView!
    
    var blinkTimer: NSTimer?
    var blinkIdx: Int = 0
    
    func lightBlink() {
        ++blinkIdx
        if blinkIdx > 12 {
            blinkIdx = 1
        }
        
        blinkImageView.image = UIImage(named: "\(blinkIdx).png")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blinkTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "lightBlink", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

