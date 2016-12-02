//
//  ViewController.swift
//  TestSwiftHBKit
//
//  Created by boob on 16/12/2.
//  Copyright © 2016年 YY.COM. All rights reserved.
//

import UIKit

class ViewController: HBBaseTableViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        for index in 1...100{
//            let cs = HBCellStruct.cell_x_x_struct("cell" + String(index), detailvalue: "", target: self, selectAction: Selector(("selectAction:"))) as HBCellStruct
//            cs.dictionary.setObject("random", forKey: key_cellstruct_background as NSCopying);
//            self.dataDictionary.setObject(cs, forKey: self.key_indexpath(0, row: index) as NSCopying)
//        }
        
        self.loadjsonfileConfig("TestJson", watch_directory: "resource")
//        self.loadplistConfig("Testplistvc", watch_directory: "resource")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectAction(cs:HBCellStruct)->(){
        print(cs.description);
    }

}

