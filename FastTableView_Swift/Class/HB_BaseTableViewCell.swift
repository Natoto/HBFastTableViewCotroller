//
//  HB_TableViewCell.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit

class HB_BaseTableViewCell: UITableViewCell {

    var object:AnyObject?
    func setcellTitle(title:String)
    {
        if !title.isEmpty
        {
            self.textLabel?.text = title;
        }
    }
    
    func setcellObject(object:AnyObject)
    {
        self.object = object;
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
