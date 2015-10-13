//
//  HB_CELLSTRUCT.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit
import Foundation

typealias CELL_STRUCT = HB_CELLSTRUCT

class HB_CELLSTRUCT: NSObject {
    //常用的
    var cellheight:Float = 44.0
    var sel_selector:Selector = nil
    var cellclass:String = "HB_BaseTableViewCell"
    var title:String? = "Title"
    var key_indexpath:String? = nil
    var accessory:Bool? = false
    var selectionStyle:Bool? = true
    var delegate:AnyObject? = nil
    var dictionary:[String:AnyObject]? = nil
    var picture:String! //? = nil
    var object:AnyObject! //= nil
    //MARK: section -
    var sectiontitle:String = ""
    var sectionfont:Float = 12.0
    var sectionfooter:String = ""
    var sectionfooterheight:Float = 0
    
    //MARK : CELL SETTING
    var textAlignment:String = "left"
    var titlecoloer:String = "black"
    var detailtitle:String? = nil
    var value:String? = nil
    var tempvalue:String? = nil
    var xibvalue:String? = nil//xib
    var subvalue2:String? = nil
    var placeHolder:String? = nil
    var cellctr:String? = nil
    var deselectRow:Bool = true
    var picturecolor:String? = "gray"
    
    var CellStyleValue:Int? = 1
    
    init(title:String)
    {
        self.title! = title
    }
    
    class func xib()->String
    {
        return "xib"
    }
}

//var PerPageDataCount: Int?
//MARK: 扩展
var key_rightComponts:Int?
var key_rightvalue:Int?
var key_imageRight:Int?

extension HB_CELLSTRUCT
{
    //MARK: EX
    var rightComponts:String
    {
        get{
          let right = objc_getAssociatedObject(self, &key_rightComponts) as? String
            return right!
        }
        set{
            objc_setAssociatedObject(self, &key_rightComponts, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var rightValue:String
    {
        get{
            let right = objc_getAssociatedObject(self, &key_rightvalue) as? String
            return right!
        }
        set{
            objc_setAssociatedObject(self, &key_rightvalue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var imageRight:Bool{
        get{
            let obj = objc_getAssociatedObject(self, &key_imageRight) as? Bool
            return obj!
        }
        set{
            objc_setAssociatedObject(self, &key_imageRight, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    var imageCornerRadius:Bool {
        get{
            let obj = objc_getAssociatedObject(self, &key_imageRight) as? Bool
            return obj!
        }
        set{
            objc_setAssociatedObject(self, &key_imageRight, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
//    var delegate:AnyObject? = nil
}
/*

@property(nonatomic,retain) NSString  * rightComponts;
@property(nonatomic,retain) NSString  * rightValue;
@property(nonatomic,assign) BOOL        accessory;
@property(nonatomic,assign) BOOL        selectionStyle;
@property(nonatomic,assign) BOOL        imageRight;
@property(nonatomic,assign) BOOL        imageCornerRadius;
@property(nonatomic,assign) int         CellStyleValue;//修改cell默认的样式 0 1 2
@property(nonatomic,retain) NSMutableArray * array;
@property(nonatomic,retain) NSMutableArray * uploadobjcts;
@property(nonatomic,retain) NSMutableDictionary *dictionary;
@property(nonatomic,assign) NSInteger       uploadingIndex;
@property(nonatomic,assign) id              delegate;
@property(nonatomic,retain) id              object;
@property(nonatomic,retain) id              object2;
@property(nonatomic,assign) id          sectionHeaderView;
@property(nonatomic,retain) NSString    * inputAccessoryView;
@property(nonatomic,retain) NSString    * inputView;
*/