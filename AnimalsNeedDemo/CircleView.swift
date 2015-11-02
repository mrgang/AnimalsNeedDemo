//
//  CircleView.swift
//  CustomViewLG
//
//  Created by ligang on 15/3/31.
//  Copyright (c) 2015年 ligang. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    let pil = CGFloat(3.141592653/180.0)
    var subv:UIButton?
    var isMoving = true
    var goalValue:Int = 0 {
        didSet{
            if goalValue > 360 || goalValue < 0  {
                goalValue = 0
            }
            self.setNeedsDisplay()
        }
        
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        let midX = rect.midX //中心x
        let midY = rect.midY //中心y
        let size = rect.size //view的大小
        let radio = (3/8) * min(size.height, size.width)
        layer.cornerRadius = 1/2*min(size.height, size.width)
        layer.masksToBounds = true
        if let _ = subv {
            subv!.setTitle("\(goalValue)", forState: UIControlState.Normal)
        }else{
            subv = UIButton(frame: CGRectMake(midX-20,midY-20,40,40))
            subv?.titleLabel?.text = "\(goalValue)"
            subv?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            subv?.addTarget(self, action: "changeState", forControlEvents: UIControlEvents.TouchUpInside)
            addSubview(subv!)
        }
        CGContextSetLineWidth(context, radio/2)
        CGContextSetStrokeColorWithColor(context, UIColor(red: 255, green: 255, blue: 255, alpha: 0.2).CGColor)
        CGContextAddArc(context, midX, midY, radio, 0, 6.3, 0)
        CGContextStrokePath(context)
        CGContextSetLineWidth(context, radio/4)
        for i in 0...180 {
            if 2*i+1 < goalValue{
                CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
            } else {
                CGContextSetStrokeColorWithColor(context, UIColor(red: 255, green: 255, blue: 255, alpha: 0.3).CGColor)
            }
            CGContextAddArc(context, midX, midY, radio, CGFloat(2*i) * pil, CGFloat(2*i+1) * pil, 0)
            CGContextStrokePath(context)
        }
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "gpp", userInfo: nil, repeats: false)
        
    }
    func gpp(){
        if isMoving {
            goalValue += 1
        }
    }
    func changeState(){
        if isMoving{
            isMoving = false
        }else{
            isMoving = true
            gpp()
        }
    }
}
