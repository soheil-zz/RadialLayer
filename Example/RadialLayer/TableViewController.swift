//
//  TableViewController.swift
//  RadialLayer
//
//  Created by Soheil on 11/16/2015.
//  Copyright (c) 2015 Soheil. All rights reserved.
//

import UIKit

struct RadialLayerConstants {
    static let speed = 1
}

class TableViewController: UITableViewController {
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 75
        
        var frame = tableView.frame
        frame.size.height /= 2
        tableView.frame = frame
        
        
        let bottomView = UIView()
        var frameBottom = tableView.frame
        frameBottom.origin.y = frameBottom.size.height
        bottomView.frame = frameBottom
        tableView.tableFooterView = bottomView
        
        let button = UIButton(type: UIButtonType.System)
        button.frame = CGRectMake(10, 10, 130, 40)
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(button)
        
        
        let imageView = UIImageView(frame: CGRectMake(10, 60, 130, 130))
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.image = UIImage(named: "radiant.png")
        bottomView.addSubview(imageView)
        
        label = UILabel(frame: CGRectMake(180, 10, 150, 40))
        bottomView.addSubview(label)
    }
    
    func imageTapped(img: AnyObject) {
        label.text = "Image tapped"
    }
    
    func buttonAction(sender:UIButton!) {
        label.text = "Button tapped"
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "mycell"
        
        var cell: UITableViewCell! = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        
        if cell == nil {
            cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        }
        
        cell.textLabel?.text = "hi"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        label.text = "Cell \(indexPath.row) tapped"
    }
}
