//
//  ViewController.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/9.
//  Copyright © 2015年 nonato. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: HB_BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         
        print("1")
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            print("2")
        }
        print("3")
        
       self.TABLEVIEW_REGISTERXIBCELL_CLASS("TestTableViewCell")
        
        for  index in 0...10
        {
            let title = "title" + String(index)
            let cellstruct6:CELL_STRUCT! = CELL_STRUCT.init(title: title)
            cellstruct6.cellclass = "TestTableViewCell"
            cellstruct6.xibvalue = "xib"
            self.dataDictionary[self.KEY_INDEXPATH(0, ROW: index)] = cellstruct6
        }
//        [super viewDidLoad];
//        NSLog(@"1");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//        });
//        NSLog(@"3"); 
        
        
        //Alamofire.request(.GET, "http://httpbin.org/get")
        
//        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
//            .response { request, response, data, error in
//                print("request = \(request)")
//                print("response =\(response)")
//                print("error = \(error)")
//        }
        
       Alamofire.request(.GET, "http://httpbin.org/get").responseString(encoding: NSUTF8StringEncoding) { (request, response, result) -> Void in
            print("request = \(request)")
            print("response =\(response)")
            print("result = \(result)")
        }
//            .responseString { _, _, string, _ in
//                print(string)
//            }
//            .responseJSON { _, _, JSON, _ in
//                print(JSON)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

