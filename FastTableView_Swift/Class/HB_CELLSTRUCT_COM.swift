//
//  HB_CELLSTRUCT_COM.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit

typealias CELL_STRUCT_Common = HB_CELLSTRUCT_COM

class HB_CELLSTRUCT_COM: NSObject {
    class func cell_x_x_struct(title:String,detailvalue:String,target:AnyObject,selectAction:Selector)->HB_CELLSTRUCT
    {
        let cellstruct:HB_CELLSTRUCT = HB_CELLSTRUCT.init(title: title)
        cellstruct.detailtitle = detailvalue;
        cellstruct.delegate = target
        cellstruct.sel_selector = selectAction
        return cellstruct
    }
    
    
}
extension UIViewController
{
    func SECTION()->String
    {
        return "section"
    }
    func SEPERATOR()->String
    {
        return "_"
    }
    
    
    func KEY_INDEXPATH(SECTION:Int, ROW:Int) ->String
    {
        return self.SECTION() + String(SECTION) + self.SEPERATOR() + String(ROW)
    }
    
    func KEY_SECTION(SECTION:Int) -> String
    {
        return self.SECTION() + String(SECTION)
    }
    
    func KEY_SECTION_MARK(SECTION:Int) -> String
    {
        // [NSString stringWithFormat:@"section%d_",(int)SECTION];
        return self.SECTION() + String(SECTION) + self.SEPERATOR()
    }
    
    func KEY_INDEXPATH_SECTION_STR(INDEXPATHKEY:String) ->String
    {
        // ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil);
        var substring = ""
        if INDEXPATHKEY.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 9
        {
            let sectionRange:Range = INDEXPATHKEY.rangeOfString(self.SECTION())!
            let seperatorRange:Range = INDEXPATHKEY.rangeOfString(self.SEPERATOR())!
            substring = INDEXPATHKEY.substringWithRange(Range.init(start: sectionRange.endIndex, end: seperatorRange.startIndex));
        }
        return substring
    }
    
    func KEY_INDEXPATH_ROW_STR(INDEXPATHKEY:String) ->String
    {
        // ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil);
        var substring = ""
        if INDEXPATHKEY.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 9
        {
            //let sectionRange:Range = INDEXPATHKEY.rangeOfString(self.SECTION())!
            let seperatorRange:Range = INDEXPATHKEY.rangeOfString(self.SEPERATOR())!
            substring = INDEXPATHKEY.substringFromIndex(seperatorRange.endIndex) //INDEXPATHKEY.substringWithRange(Range.init(start: sectionRange.endIndex, end: seperatorRange.startIndex));
        }
        return substring
    }
    
    
    func MAX_SECTION(ALLINDEXPATHKEYS:[String]) -> Int
    {
        var maxsection:Int = 0;
        for  key in ALLINDEXPATHKEYS
        {
            let section:String? = self.KEY_INDEXPATH_SECTION_STR(key)
            if Int(section!) > maxsection
            {
                maxsection = Int(section!)!
            }
        }
        return maxsection + 1;
    }
    
    func MAX_ROW(SECTION:Int, ALLINDEXPATHKEYS: [String]) -> Int
    {
        var maxrow:Int = 0;
        let sectionmark:String = self.KEY_SECTION_MARK(SECTION);
        
        for   key in ALLINDEXPATHKEYS
        {
            if (key.rangeOfString(sectionmark)?.startIndex != nil)
            {
                let section:String? = self.KEY_INDEXPATH_ROW_STR(key)
                if Int(section!) > maxrow
                {
                    maxrow = Int(section!)!
                }
                
            }
        }
        return maxrow;
    }    
    /*
    -(NSString *)KEY_INDEXPATH:(NSInteger )SECTION ROW:(NSInteger)ROW;
    -(NSString *)KEY_SECTION:(NSInteger)SECTION;
    -(NSString *)KEY_SECTION_MARK:(NSInteger)SECTION;
    -(NSString *)KEY_SECTION_INDEX_STR:(NSString *)INDEXPATHKEY;
    -(NSString *)KEY_INDEXPATH_SECTION_STR:(NSString *)INDEXPATHKEY;
    -(NSString *)KEY_INDEXPATH_ROW_STR:(NSString *)INDEXPATHKEY;
    */
}

//MARK:常用的变量

let key_cellstruct_sectionfooterheight: String = "key_cellstruct_sectionfooterheight"
let key_cellstruct_cellheight: String = "key_cellstruct_cellheight"
let key_cellstruct_selector: String = "key_cellstruct_sel_selector"
let key_cellstruct_selectionStyle: String = "key_cellstruct_selectionStyle"
let key_cellstruct_key_indexpath: String = "key_cellstruct_key_indexpath"
let key_cellstruct_sectiontitle: String = "key_cellstruct_sectiontitle"
let key_cellstruct_sectionfooter: String = "key_cellstruct_sectionfooter"
let key_cellstruct_sectionheight: String = "key_cellstruct_sectionheight"
let key_cellstruct_sectionHeaderView: String = "key_cellstruct_sectionHeaderView"
let key_cellstruct_title: String = "key_cellstruct_title"
let key_cellstruct_titlecolor: String = "key_cellstruct_titlecolor"
let key_cellstruct_textAlignment: String = "key_cellstruct_textAlignment"
let key_cellstruct_placehoder: String = "key_cellstruct_placehoder"
let key_cellstruct_detailvalue: String = "key_cellstruct_detailvalue"
let key_cellstruct_imageCornerRadius: String = "key_cellstruct_imageCornerRadius"
let key_cellstruct_imageRight: String = "key_cellstruct_imageRight"
let key_cellstruct_txtsecureTextEntry: String = "key_cellstruct_txtsecureTextEntry"
let key_cellstruct_txtkeyboardtype: String = "key_cellstruct_txtkeyboardtype"
let key_cellstruct_accessory: String = "key_cellstruct_accessory"
let key_cellstruct_cellclass: String = "key_cellstruct_cellclass"
let key_cellstruct_delegate: String = "key_cellstruct_delegate"
let key_cellstruct_background: String = "key_cellstruct_background"
let key_cellstruct_profile: String = "key_cellstruct_profile"
let key_cellstruct_xibvalue: String = "key_cellstruct_xibvalue"
let key_cellstruct_subvalue2: String = "key_cellstruct_subvalue2"
let key_cellstruct_active: String = "key_cellstruct_active"
let key_cellstruct_editing: String = "key_cellstruct_editing"
let key_cellstruct_editabled: String = "key_cellstruct_editabled"
let key_cellstruct_pushcontroller: String = "key_cellstruct_pushcontroller"
let key_cellstruct_pushcontroller_xib: String = "key_cellstruct_pushcontroller_xib"
let value_cellstruct_black: String = "black"
let value_cellstruct_Gray: String = "Gray"
let value_cellstruct_lightGray: String = "lightGrayColor"
let value_cellstruct_write: String = "white"
let value_cellstruct_gray: String = "gray"
let value_cellstruct_clear: String = "clear"
let value_cellstruct_red: String = "red"
let value_cellstruct_green: String = "green"
let value_cellstruct_blue: String = "blue"
let value_cellstruct_cyan: String = "cyan"
let value_cellstruct_yellow: String = "yellow"
let value_cellstruct_magenta: String = "magenta"
let value_cellstruct_orange: String = "orange"
let value_cellstruct_purple: String = "purple"
let value_cellstruct_brown: String = "brown"
let value_cellstruct_textAlignment_left: String = "left"
let value_cellstruct_textAlignment_right: String = "right"
let value_cellstruct_textAlignment_center: String = "center"
let value_cellstruct_txtkeyboardtype_number: String = "number"
let value_cellstruct_txtkeyboardtype_default: String = "default"

