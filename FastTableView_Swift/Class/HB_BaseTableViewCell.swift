//
//  HB_TableViewCell.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit

//@objc(HB_BaseTableViewCell) //自动转换的方法名
class HB_BaseTableViewCell: UITableViewCell {

    var indexPath:NSIndexPath?
    var selector:Selector?
    var delegate:AnyObject?
    var dictionary:[String:AnyObject]?
    var object:AnyObject?

    override required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    func setcelldictionary(dictionary:[String:AnyObject]?)
    {
        self.dictionary = dictionary;
    }
    func setcellobject(object:AnyObject?)
    {
        self.object = object
    }
    func setcelldelegate(delegate:AnyObject)
    {
        self.delegate = delegate
    }
    func setcellProfile(profile:String?){}
    func setcellTitle(title:String?){
        if title != nil {
            self.textLabel?.text = title;
        }
    }
    func setcellObject(object:AnyObject?){
        self.object = object;
    }
    func setcellTitleColor(color:String?){}
    func setcellValue(value:String?){}
    func setcellValue2(value:String?){}
    func setcellRightValue(value:String?){}
    func setcellplaceholder(placeholder:String?){
        if placeholder != nil {
            
        }
    }
    func setcellArray(array:[AnyObject]){}
    func setinputAccessoryView(inputAccessoryView:String?){}
//    -(void)setinputView:(NSString *)inputView;
//    -(void)setcelldetailtitle:(NSString *)detailtitle;
//    -(void)setcellimageCornerRadius:(BOOL)CornerRadius;
 
}
