//
//  HB_BaseTableViewController.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit
 
class HB_BaseTableViewController: HB_BaseViewController {

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
    //注册NIB 和 Class
    func TABLEVIEW_REGISTERXIBCELL_CLASS(CELLCLSSTR:String)
    {
        self.TableView.registerClass(NSObject.swiftClassFromString(CELLCLSSTR),
            forCellReuseIdentifier: CELLCLSSTR)
        self.TableView.registerNib(UINib.init(nibName: CELLCLSSTR, bundle: nil), forCellReuseIdentifier: CELLCLSSTR)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getcellstructWithIndexPath(indexPath:NSIndexPath) ->HB_CELLSTRUCT
    {
        let key_indexpath:String? = self.KEY_INDEXPATH(indexPath.section, ROW: indexPath.row)
        let cellstruct:HB_CELLSTRUCT! = self.dataDictionary[key_indexpath!] as! HB_CELLSTRUCT
        return cellstruct;
    }
    

}
//MARK: - datasource
extension HB_BaseTableViewController:UITableViewDataSource
{
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
            let ClassName:String =  cellstruct.cellclass
            let cls:HB_BaseTableViewCell.Type? = NSObject.swiftClassFromString(cellstruct.cellclass) as? HB_BaseTableViewCell.Type // NSClassFromString(ClassName) as? HB_BaseTableViewCell.Type
            assert(cls != nil, "class not found,please check className")
            
            if cellstruct.xibvalue != nil &&  cellstruct.xibvalue == HB_CELLSTRUCT.xib()
            {
                Cell = NSBundle.mainBundle().loadNibNamed(ClassName, owner: self, options: nil).last as? HB_BaseTableViewCell
            }
            else
            {
                Cell = cls!.init(style: self.getTableViewCellStyleFrom(cellstruct.CellStyleValue!), reuseIdentifier: identifier01)
            }
        }
        if Cell?.dynamicType.isSubclassOfClass(HB_BaseTableViewCell) == true
        {
            Cell?.delegate = self
            Cell?.indexPath = indexPath
            Cell?.selector = cellstruct.sel_selector
            Cell?.selectionStyle = cellstruct.selectionStyle == true ? UITableViewCellSelectionStyle.Default : UITableViewCellSelectionStyle.None
            Cell?.accessoryType = cellstruct.accessory == true ? UITableViewCellAccessoryType.DetailButton : UITableViewCellAccessoryType.None
            Cell?.setcellTitle(cellstruct!.title!)
            Cell?.setcellplaceholder(cellstruct!.placeHolder)
            Cell?.setcellProfile(cellstruct!.picture)
            Cell?.setcellobject(cellstruct!.object)
            Cell?.setcelldictionary(cellstruct.dictionary)
            
        }
        
        let key_sectionstr = self.KEY_INDEXPATH_SECTION_STR(key_indexpath!)
        let key_rowstr = self.KEY_INDEXPATH_ROW_STR(key_indexpath!)
        print(key_indexpath! + " section: " + key_sectionstr + " row: "  + key_rowstr)
        
        return Cell!
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cellstruct:HB_CELLSTRUCT! = self.getcellstructWithIndexPath(indexPath)
        return CGFloat(cellstruct.cellheight)
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
}
// MARK: - delegate
extension HB_BaseTableViewController:UITableViewDelegate
{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.getcellstructWithIndexPath(indexPath).deselectRow == true
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
        }
    }
     
}


//  MARK: 计算CELL高度
var key_templateCellsByIdentifiers:Int?
extension UITableView
{
    func fd_templateCellForReuseIdentifier(identifier: String) -> AnyObject {
        assert(identifier.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0, "Expect a valid identifier ")
        var templateCellsByIdentifiers:[String : UITableViewCell] = (objc_getAssociatedObject(self, &key_templateCellsByIdentifiers) as? [ String : UITableViewCell])!
        var templateCell: UITableViewCell? = templateCellsByIdentifiers[identifier]!
        if templateCell == nil {
            templateCell = self.dequeueReusableCellWithIdentifier(identifier)
            assert(templateCell != nil, "Cell must be registered to table view for identifier - \(identifier)")
            templateCell!.contentView.translatesAutoresizingMaskIntoConstraints = false
            templateCellsByIdentifiers[identifier] = templateCell
        }
        return templateCell!
    }
    //configuration:(void (^)(id cell))configuration

    func hb_heightForCellWithIdentifier(identifier: String, configuration:(cell:UITableViewCell) -> Void) -> CGFloat {
        
        let cell: UITableViewCell = self.fd_templateCellForReuseIdentifier(identifier) as! UITableViewCell
        cell.prepareForReuse()
        configuration(cell: cell)
        
        var contentViewWidth: CGFloat = CGRectGetWidth(self.frame)
        if cell.accessoryView != nil {
            contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView!.frame)
        }
        else {
            let systemAccessoryWidths: [UITableViewCellAccessoryType:CGFloat] = [UITableViewCellAccessoryType.None: 0,
                UITableViewCellAccessoryType.DisclosureIndicator: 34,
                UITableViewCellAccessoryType.DetailDisclosureButton:68,
                UITableViewCellAccessoryType.Checkmark:40,
                UITableViewCellAccessoryType.DetailButton:48]
            contentViewWidth -= systemAccessoryWidths[cell.accessoryType]!
        }
        var fittingSize:CGSize? = CGSizeZero
        
        let selector:Selector = Selector("sizeThatFits:")
        let inherited = cell.isMemberOfClass(UITableViewCell)
        let overrided = cell.dynamicType.instanceMethodForSelector(selector) != UITableViewCell.instanceMethodForSelector(selector)
        if inherited == true && overrided == false
        {
            assert(false, "Customized cell must override '-sizeThatFits:' method if not using auto layout.")
        }
        fittingSize = cell.sizeThatFits(CGSizeMake(contentViewWidth, 0))
        if self.separatorStyle != UITableViewCellSeparatorStyle.None
        {
            fittingSize?.height += 1.0 / UIScreen.mainScreen().scale
        }
        
        return (fittingSize?.height)!
    }
}

extension NSObject {
    // create a static method to get a swift class for a string name
    class func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        if  let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
            // generate the full name of your class (take a look into your "YourProject-swift.h" file)
            let classStringName = appName! + "." + className
            // return the class!
            return NSClassFromString(classStringName)
        }
        return nil;
    }
}