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
        cellstruct.cel_selector = selectAction
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