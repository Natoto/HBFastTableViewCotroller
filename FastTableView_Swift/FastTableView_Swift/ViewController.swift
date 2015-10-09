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
        
        for  index in 1...10
        {
            let title = "title" + String(index)
            let cellstruct6:CELL_STRUCT! = CELL_STRUCT.init(title: title)
            self.dataDictionary[self.KEY_INDEXPATH(0, ROW: index)] = cellstruct6
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

