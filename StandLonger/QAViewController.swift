//
//  QAViewController.swift
//  StandLonger
//
//  Created by 韦体东 on 15/2/24.
//  Copyright (c) 2015年 韦体东. All rights reserved.
//

import UIKit

class QAViewController: UIViewController {

    func onBack() {
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    var allQuestions = [
        ["谁不是古代十大美女？", "貂蝉", "王昭君", "董小宛", "芙蓉"],
        ["明朝开国皇帝是？", "朱元璋", "刘邦", "李世民", "刘伯温"],
        ["老公老婆在一起谁应该洗碗？", "老公", "老婆", "一起洗", "孩子"],
    ]
    
    var allAnswer = [4, 1, 3]
    var allAnswerUser:[Bool] = [Bool](count: 3, repeatedValue:false)
    var currentQ = 0
    
    var btns = [UIButton]()
    var labels:[UILabel] = Array<UILabel>()
    var timerLabel:UILabel?
    var timerNext:NSTimer?
    
    func nextQuestion() {
        if currentQ == allQuestions.count - 1 {
            //labels[0].text = "恭喜你，答题完成。"
            var alert = UIAlertController(title: "提示", message: "已经完成所有题", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "再来一次", style: .Default, handler: {act in
                self.currentQ = -1
                self.nextQuestion()
            }))
            alert.addAction(UIAlertAction(title: "退出", style: .Default, handler: {
            act in
                self.dismissViewControllerAnimated(false, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "回到主界面", style: .Default, handler: {
                act in
                var sb = UIStoryboard(name: "Main", bundle: nil)
                var vc = sb.instantiateViewControllerWithIdentifier("myFirst") as ViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }else {
            for var i = 0; i < btns.count; ++i {
                btns[i].enabled = true
                btns[i].setImage(UIImage(named: "平时状态@2x.png"), forState: .Normal)

            }
            fill()
            timerNext?.invalidate()
            timerNext = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "nextQuestion", userInfo: nil, repeats: false)
        }
    }
    func judgeResult(sender:UIButton) {
        allAnswerUser[currentQ] = sender.tag == allAnswer[currentQ]
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setInteger(currentQ, forKey: "currentQ")
        ud.setBool(allAnswerUser[currentQ], forKey: "answer\(currentQ)")
        sender.setImage(UIImage(named: allAnswerUser[currentQ] ? "答对@2x.png":"答错@2x.png"), forState: UIControlState.Normal)
        for var i = 0; i < btns.count; ++i {
            btns[i].enabled = false
        }
        timerNext?.invalidate()
        timerNext = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "nextQuestion", userInfo: nil, repeats: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var bgImage = UIImage(named: "对战背景05@2x.png")
        var bgViewC = UIImageView(image: bgImage)
        bgViewC.frame = CGRect(x: 0, y: 0, width: 480, height: 320)
        self.view.addSubview(bgViewC)
        println(NSTemporaryDirectory())
        
        var bgImageback = UIImage(named: "left_arrow.png")
        var btnBack = UIButton(frame: CGRect(x: 5, y: 140, width: 50, height: 50))
        btnBack.setImage(bgImageback, forState: .Normal)
        self.view.addSubview(btnBack)
        btnBack.addTarget(self, action: "onBack", forControlEvents: .TouchUpInside)
        
        var questionLabel = UILabel(frame: CGRectMake(80, 100, 320, 80))
        questionLabel.text = allQuestions[currentQ][0]
        questionLabel.textAlignment = .Center
        self.view.addSubview(questionLabel)
        labels.append(questionLabel)
        
        timerLabel = UILabel(frame: CGRectMake(50, 30, 80, 30))
        timerLabel!.text = "00:00"
        timerLabel!.textAlignment = .Center
        timerLabel!.backgroundColor = UIColor.blueColor()
        timerLabel!.textColor = UIColor.whiteColor()
        self.view.addSubview(timerLabel!)
        
        for var i = 0; i < 4; ++i {
            var rect:CGRect = CGRectMake(CGFloat(30+(i%2)*200), CGFloat(210+i/2*50), 220, 40)
            var answer = UIButton(frame: rect)
            answer.setImage(UIImage(named: "平时状态@2x.png"), forState: .Normal)
            answer.tag = i
            btns.append(answer)
            
            var label = UILabel(frame: rect)
            label.text = allQuestions[currentQ][i+1]
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            labels.append(label)
            self.view.addSubview(answer)
            self.view.addSubview(label)
            answer.addTarget(self, action: "judgeResult:", forControlEvents: .TouchUpInside)
        }
    }
    
    func fill() {
        currentQ = (currentQ+1) % allQuestions.count
        for var i = 0; i < labels.count; ++i {
            labels[i].text = allQuestions[currentQ][i]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}