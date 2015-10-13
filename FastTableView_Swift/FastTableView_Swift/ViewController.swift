//
//  ViewController.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit

class ViewController: HB_BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        print("1")
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            print("2")
        }
        print("3")
        
       self.TABLEVIEW_REGISTERXIBCELL_CLASS("TestTableViewCell")
        
        for  index in 0...10
        {
            let title = "title" + String(index)
            let cellstruct6:CELL_STRUCT! = CELL_STRUCT.init(title: title)
            cellstruct6.cellclass = "TestTableViewCell"
            cellstruct6.xibvalue = "xib"
            self.dataDictionary[self.KEY_INDEXPATH(0, ROW: index)] = cellstruct6
        }
//        [super viewDidLoad];
//        NSLog(@"1");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//        });
//        NSLog(@"3"); 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

