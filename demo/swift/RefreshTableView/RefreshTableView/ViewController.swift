//
//  ViewController.swift
//  RefreshTableView
//
//  Created by zeno on 15/9/10.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

import UIKit

class ViewController: HB_BaseTableViewController {
 
    var cellstruct_login:CELL_STRUCT!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PENG SWIFT IM";
        //self.noHeaderFreshView = false
        //self.noFooterView = false
        
       self.cellstruct_login = self.createcellstruct()
       self.cellstruct_login.title = "登陆"
        
       self.dataDictionary.setObject(self.cellstruct_login, forKey: KEY_INDEXPATH(0, ROW: 0))
        
       //self.tableView.header.beginRefreshing()
        
//        var ctr = LoginViewController.init(nibName : "LoginViewController" , bundle : nil)
//        self.presentViewController(ctr, animated: true) { () -> Void in
//            
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /**
    行选择
    
    - parameter cellstruct: 参数
    */
    func cellSelector(_ cellstruct:CELL_STRUCT)
    {
//        if cellstruct.key_indexpath == nil
//        {
//            assertionFailure("cellstruct.key_indexpath is nil")
//        }
//        var sectionstr:NSString! = self.KEY_INDEXPATH_SECTION_STR(cellstruct.key_indexpath)
//        var rowstr:NSString! = self.KEY_INDEXPATH_ROW_STR(cellstruct.key_indexpath)
        
        if(cellstruct_login == cellstruct)
        {
            let ctr:LoginViewController! = LoginViewController.init(nibName : "LoginViewController", bundle : nil)
            self.presentViewController(ctr, animated: true, completion: { () -> Void in
                
            })
            return
        }
        else
        {
            print("cell selector \(cellstruct.title)")
            let ctr:DetailViewController! = DetailViewController.init(nibName : "DetailViewController", bundle : nil)
            ctr.title = cellstruct.title;
            ctr.atitle = String(cellstruct.title);
            print("ctr.title \(ctr.atitle)")
            self.navigationController?.pushViewController(ctr, animated: true)
        }
    }
    /**
    下拉刷新
    */
    override func refreshView() {
       self.dataDictionary.removeAllObjects()
        for index in 0...10
        {
            var keypathstr:NSString!
            keypathstr = self.KEY_INDEXPATH(0, ROW:index);
            let cellstruct:CELL_STRUCT! = self.createcellstruct()
            cellstruct.title =  "section \(0) row \(index)"
            cellstruct.key_indexpath =  self.KEY_INDEXPATH(0, ROW: index)
            self.dataDictionary.setObject(cellstruct, forKey:keypathstr);
        }
        self.tableView.reloadData()
        self.tableView.header.endRefreshing()
    }
    /**
    上拉 加载更多
    */
    override func getNextPageView() {
        let sectionindex:Int! = self.dataDictionary.count/10 + 1
        for index in 0...10
        {
            var keypathstr:NSString!
            keypathstr = self.KEY_INDEXPATH(sectionindex, ROW:index);
            let cellstruct:CELL_STRUCT! = self.createcellstruct()
            cellstruct.title = "section \(sectionindex - 1) row \(index)"
            cellstruct.key_indexpath =  self.KEY_INDEXPATH(sectionindex, ROW: index)
            self.dataDictionary.setObject(cellstruct, forKey:keypathstr);
        }
        self.tableView .reloadData()
        self.tableView.footer.endRefreshing()
    }
    
    
    /**
    创建CELLSTRUCT
    
    - returns: CELLSTRUCT 对象
    */
    func createcellstruct()->CELL_STRUCT
    {
        let cellstruct:CELL_STRUCT! = CELL_STRUCT_Common.cell_x_x_struct("", detailvalue: "", target: self, selectAction: Selector("cellSelector:"))
        cellstruct.sectionheight = 10
        
        return cellstruct;
    }
    
    
}

