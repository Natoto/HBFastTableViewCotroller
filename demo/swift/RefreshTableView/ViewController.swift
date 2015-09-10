//
//  ViewController.swift
//  RefreshTableView
//
//  Created by zeno on 15/9/10.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

import UIKit

class ViewController: HB_BaseTableViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PENG SWIFT IM";
        self.noHeaderFreshView = false
        self.noFooterView = false
        
       self.tableView.header.beginRefreshing()
    }
    
    func createcellstruct()->CELL_STRUCT
    {
        var cellstruct:CELL_STRUCT! = CELL_STRUCT_Common.cell_x_x_struct("", detailvalue: "", target: self, selectAction: Selector("cellSelector:"))
        cellstruct.sectionheight = 10
        
        return cellstruct;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cellSelector(cellstruct:CELL_STRUCT)
    {
        println("cell selector \(cellstruct.title)")
    }
    
    override func refreshView() {
       self.dataDictionary.removeAllObjects()
        for index in 0...10
        {
            var keypathstr:NSString!
            keypathstr = self.KEY_INDEXPATH(0, ROW:index);
            var cellstruct:CELL_STRUCT! = self.createcellstruct()
            cellstruct.title = "section \(0) row \(index)"
            self.dataDictionary.setObject(cellstruct, forKey:keypathstr);
        }
        self.tableView.reloadData()
        self.tableView.header.endRefreshing()
    }
    
    override func getNextPageView() {
        var sectionindex:Int! = self.dataDictionary.count/10 + 1
        for index in 0...10
        {
            var keypathstr:NSString!
            keypathstr = self.KEY_INDEXPATH(sectionindex, ROW:index);
            var cellstruct:CELL_STRUCT! = self.createcellstruct()
            cellstruct.title = "section \(sectionindex - 1) row \(index)"
            self.dataDictionary.setObject(cellstruct, forKey:keypathstr);
        }
        self.tableView .reloadData()
        self.tableView.footer.endRefreshing()
    }
    
}

