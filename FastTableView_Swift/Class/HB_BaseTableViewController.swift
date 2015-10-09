//
//  HB_BaseTableViewController.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit
 
class HB_BaseTableViewController: HB_BaseViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var dataDictionary:Dictionary<String,AnyObject> = {
        var dic = Dictionary<String,HB_CELLSTRUCT>() //NSMutableDictionary(capacity: 0)
        return dic
        }()
    
    lazy var TableView:UITableView = {
        var  table:UITableView = UITableView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height), style: UITableViewStyle.Plain)
        table.delegate = self;
        table.dataSource = self;
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.TableView);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let allkeys = Array(self.dataDictionary.keys)
        return self.MAX_SECTION(allkeys)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let allkeys:[String] = Array(self.dataDictionary.keys)
        return self.MAX_ROW(section, ALLINDEXPATHKEYS:allkeys)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell:HB_BaseTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? HB_BaseTableViewCell
        if  (Cell == nil)
        {
            Cell = HB_BaseTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        let key_indexpath:String? = self.KEY_INDEXPATH(indexPath.section, ROW: indexPath.row)
        let cellstruct:HB_CELLSTRUCT! = self.dataDictionary[key_indexpath!] as! HB_CELLSTRUCT
      
        Cell?.setcellTitle(cellstruct!.title)
        
//        let key_indexpath = self.KEY_INDEXPATH(indexPath.section, ROW: indexPath.row)
        let key_sectionstr = self.KEY_INDEXPATH_SECTION_STR(key_indexpath!)
        let key_rowstr = self.KEY_INDEXPATH_ROW_STR(key_indexpath!)
        print(key_indexpath! + " section: " + key_sectionstr + " row: "  + key_rowstr)
        
        return Cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
