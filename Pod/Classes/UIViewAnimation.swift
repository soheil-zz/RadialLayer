//
//  UIViewAnimation.swift
//  RadialLayer
//
//  Created by Soheil Yasrebi on 11/15/15.
//  Copyright © 2015 Soheil Yasrebi. All rights reserved.
//

import Foundation
import UIKit

@objc class Configs : NSObject {
    static var isLoaded: Bool       = false
    static var props: NSMutableDictionary  = [
        "UITableViewCell":  true,
        "UIImageView":      true,
        "UIButton":         true,
        "Speed":            0.55,
        "Color":            "#CCCCCC",
        "Alpha":            0.6
    ]
    class func isActive(className: String) -> Bool {
        let value = props.objectForKey(className)
        return value != nil && value as! Bool
    }
}

@objc class UIViewAnimation : NSObject {
    static func initWithView(view: UIView) {
        if !Configs.isLoaded {
            Configs.isLoaded = true
            var myDict: NSDictionary?
            if let path = NSBundle.mainBundle().pathForResource("RadialLayer-Info", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: path)
            }
            if let dict = myDict {
                for (key, value) in dict {
                    Configs.props[key as! NSString] = value
                }
            }
            Configs.props["Color"] = hexStringToUIColor(Configs.props["Color"] as! String)
        }
        
        if let existingGestureRecognizer = view.gestureRecognizers?.first {
            existingGestureRecognizer.addTarget(self, action: "tapGestureRecognizer:")
        } else {
            let tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureRecognizer:")
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func tapGestureRecognizer(recognizer: UITapGestureRecognizer) {
        let tappedPoint = recognizer.locationInView(recognizer.view)
        animateLayerWithView(recognizer.view!, tappedPoint: tappedPoint)
    }
    
    static func animateLayerWithView(myView: UIView, tappedPoint: CGPoint) {
        let x = tappedPoint.x
        let y = tappedPoint.y
        
        let speed = Configs.props["Speed"] as! Double
        let color = Configs.props["Color"] as! UIColor
        let alpha = Configs.props["Alpha"] as! CGFloat
        
        let circleLayer = CAShapeLayer()
        myView.layer.addSublayer(circleLayer)
        
        circleLayer.frame = myView.bounds
        circleLayer.masksToBounds = true
        circleLayer.fillColor = color.colorWithAlphaComponent(alpha).CGColor
        
        let radius = max(myView.frame.width, myView.frame.height)
        let toPath = UIBezierPath(roundedRect: CGRectMake(x - radius, y - radius, radius * 2, radius * 2), cornerRadius: myView.frame.width * 2).CGPath
        let anim = CABasicAnimation(keyPath: "path")
        anim.duration = speed// / log(abs(Double(radius) - 320.0))
        anim.fromValue = UIBezierPath(roundedRect: CGRectMake(x - 17, y - 17, 34, 34), cornerRadius: 200).CGPath
        anim.toValue = toPath
        circleLayer.addAnimation(anim, forKey: "path")
        circleLayer.path = toPath
        
        let smallCircleLayer = CAShapeLayer()
        myView.layer.addSublayer(smallCircleLayer)
        
        smallCircleLayer.frame = myView.bounds
        smallCircleLayer.masksToBounds = true
        smallCircleLayer.path = UIBezierPath(roundedRect: CGRectMake(x - 17, y - 17, 34, 34), cornerRadius: 200).CGPath
        let alphaAnim = CABasicAnimation(keyPath: "fillColor")
        alphaAnim.duration = anim.duration * 0.75
        alphaAnim.fromValue = color.colorWithAlphaComponent(0.1).CGColor
        alphaAnim.toValue = UIColor.clearColor().CGColor
        smallCircleLayer.addAnimation(alphaAnim, forKey: "fillColor")
        smallCircleLayer.fillColor = UIColor.clearColor().CGColor
        
        
        let alphaAnimSlow = CABasicAnimation(keyPath: "fillColor")
        alphaAnimSlow.duration = alphaAnim.duration * 2
        alphaAnimSlow.fromValue = color.colorWithAlphaComponent(alpha).CGColor
        alphaAnimSlow.toValue = UIColor.clearColor().CGColor
        circleLayer.addAnimation(alphaAnimSlow, forKey: "fillColor")
        circleLayer.fillColor = UIColor.clearColor().CGColor
        
        
        return
    }
}