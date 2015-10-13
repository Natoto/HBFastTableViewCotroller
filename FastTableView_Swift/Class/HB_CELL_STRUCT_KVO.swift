//
//  HB_CELL_STRUCT_KVO.swift
//  FastTableView_Swift
//
//  Created by zeno on 15/10/12.
//  Copyright © 2015年 nonato. All rights reserved.
//
import Foundation
import UIKit

var cellstruct_OperationKey:Int?
var key_dataSourceContext:Int?
//var dataSourceContext = UnsafeMutablePointer<()>()
extension UIViewController {
    
    func setObservedKeyPaths(paths: AnyObject) {
        objc_setAssociatedObject(self, &cellstruct_OperationKey, paths, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    func getObservedKeyPaths() -> AnyObject {
        return objc_getAssociatedObject(self, &cellstruct_OperationKey)
    }
    
    func cellstruct_observedKeyPaths() -> NSSet {
        var outCount: CUnsignedInt = 0
        var propertlist: [AnyObject]? = self.getObservedKeyPaths() as? [AnyObject]
        if propertlist != nil {
            propertlist = Array() as [AnyObject]
            let aClass : AnyClass? =  NSClassFromString("HB_CELLSTRUCT")
            //self.dynamicType
            let properties : UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(aClass, &outCount)
            
            for  i in 0...outCount {
                let property: objc_property_t = properties[Int(i)]
                let key: String = String.init(property_getName(property))
                // NSString(cString: property_getName(property), encoding: NSUTF8StringEncoding)
                propertlist!.append(key)
            }
            self.setObservedKeyPaths(propertlist!)
        }
        return NSSet.init(array:propertlist!)
    }
    
    func cellstruct_observationOptions() -> NSKeyValueObservingOptions {
        let result = NSKeyValueObservingOptions.New.union(NSKeyValueObservingOptions.Old) 
        return result
    }
    
//    var dataSourceContext:UnsafeMutablePointer<()> {
//        get{
//            return UnsafeMutablePointer<()>()
//        }
//    }
    
    func beginObservingValuesForKeyPaths(keyPaths: NSFastGenerator, options: NSKeyValueObservingOptions, cellstructs array: [HB_CELLSTRUCT]) {
       // for keyPath in keyPaths.next() {
//        while let keyPath:String? = keyPaths.next() as? String {
//            for cellstruct:HB_CELLSTRUCT! in array {
//                cellstruct.addObserver(self, forKeyPath: keyPath!, options: options, context:nil)
//                // .addObserver(self, forKeyPath: keyPath, options: options, context: self)
//            }
//        }
    }
    
    func endObservingValuesForKeysPaths(keyPaths: NSFastGenerator, cellstructs array: [HB_CELLSTRUCT]) {
//        while let keyPath = keyPaths.next() {
//            for cellstruct: HB_CELLSTRUCT in array {
//                cellstruct.removeObserver(self, forKeyPath: keyPath as! String, context: nil)
//            }
//        }
    }
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if context == nil {
            if self.cellstruct_observedKeyPaths().containsObject(keyPath!) {
                self.handle_cell_struct_datachange(keyPath!)
                self.handle_cell_struct_datachange((object as? HB_CELLSTRUCT)!, keypath: keyPath!)
            }
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func handle_cell_struct_datachange(keyPath: String) {
    }
    
    func handle_cell_struct_datachange(cellstruct: HB_CELLSTRUCT, keypath keyPath: String) {
    }
}

//extension ZBarSymbolSet: SequenceType {
//    public func generate() -> NSFastGenerator {
//        return NSFastGenerator(self)
//    }
//}