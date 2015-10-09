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
    let cellheight:Float = 0.0
    let cel_selector:Selector = nil
    let cellclass:String = "BaseTableViewCell"
    var title:String = "Title"
    
    init(title:String)
    {
        self.title = title
    }
}
