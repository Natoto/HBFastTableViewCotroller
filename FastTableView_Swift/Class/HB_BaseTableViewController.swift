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
    
    //TODO: 设置行
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let key_indexpath:String? = self.KEY_INDEXPATH(indexPath.section, ROW: indexPath.row)
        let cellstruct:HB_CELLSTRUCT! = self.getcellstructWithIndexPath(indexPath)
        let identifier01:String = cellstruct.cellclass
        
        var Cell:HB_BaseTableViewCell?
        if cellstruct.xibvalue != nil &&  cellstruct.xibvalue == HB_CELLSTRUCT.xib()
        {
            Cell = tableView.dequeueReusableCellWithIdentifier(identifier01, forIndexPath: indexPath) as? HB_BaseTableViewCell
        }
        else
        {
            Cell = tableView.dequeueReusableCellWithIdentifier(identifier01) as? HB_BaseTableViewCell
        }
        if (Cell == nil)
        {
            let ClassName:String = cellstruct.cellclass
//            let cls:AnyClass? = NSClassFromString(ClassName)!
            
             let cls:HB_BaseTableViewCell.Type? = NSClassFromString(ClassName)! as? HB_BaseTableViewCell.Type
            assert(cls != nil, "class not found,please check className")
            
            if cellstruct.xibvalue != nil &&  cellstruct.xibvalue == HB_CELLSTRUCT.xib()
            {
                Cell = NSBundle.mainBundle().loadNibNamed(ClassName, owner: self, options: nil).last as? HB_BaseTableViewCell
            }
            else
            {
               Cell = cls!.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier01)
            }
        }
        Cell?.setcellTitle(cellstruct!.title!)
        
        let key_sectionstr = self.KEY_INDEXPATH_SECTION_STR(key_indexpath!)
        let key_rowstr = self.KEY_INDEXPATH_ROW_STR(key_indexpath!)
        print(key_indexpath! + " section: " + key_sectionstr + " row: "  + key_rowstr)
        
        return Cell!
    }
    
    func  getTableViewCellStyleFrom(cellStyleValue:Int)->UITableViewCellStyle
    {
        switch cellStyleValue{
        case 0:
            return UITableViewCellStyle.Default
        case 1:
            return UITableViewCellStyle.Value1
        case 2:
            return UITableViewCellStyle.Value2
        default:
            return UITableViewCellStyle.Default
        }
    }
    
    //MARK 其他设置用在 cellForRowAtIndexPath
    func othercellsetting(){}
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cellstruct:HB_CELLSTRUCT! = self.getcellstructWithIndexPath(indexPath)
        return CGFloat(cellstruct.cellheight)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.getcellstructWithIndexPath(indexPath).deselectRow == true
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
        }
    }
    
    func getcellstructWithIndexPath(indexPath:NSIndexPath) ->HB_CELLSTRUCT
    {
        let key_indexpath:String? = self.KEY_INDEXPATH(indexPath.section, ROW: indexPath.row)
        let cellstruct:HB_CELLSTRUCT! = self.dataDictionary[key_indexpath!] as! HB_CELLSTRUCT
        return cellstruct;
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
