//
//  DetailViewController.swift
//  RefreshTableView
//
//  Created by zeno on 15/9/11.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

import Foundation

class DetailViewController:HB_BaseViewController {
    
     var atitle:String!
    @IBOutlet weak var img_content: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    override func viewDidLoad() {
        print(self.title)
        self.lbl_title.text = self.atitle;
    }
    
}