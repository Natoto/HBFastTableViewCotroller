//
//  LoginViewController.swift
//  RefreshTableView
//
//  Created by zeno on 15/9/11.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_account: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer! = UITapGestureRecognizer(target: self, action: Selector("viewTap:"))
        self.view.addGestureRecognizer(tap)
        /*
        //拆解信号和过滤信号
        var usernameSourceSignal:RACSignal! = self.txt_account.rac_textSignal();
        
        usernameSourceSignal.filter { (obj) -> Bool in
            var str:NSString! = obj as! NSString
            return str.length > 3
        } .subscribeNext { (text) -> Void in
            println("filter->subtext: \(text)")
        }
        */
        
        //
        /* 简单信号
        usernameSourceSignal.subscribeNext { (text) -> Void in
            println(text)
        }*/
        
        
        self.txt_account.rac_textSignal().map { (obj) -> AnyObject! in
            let text:NSString! = obj as? NSString
            return text.length
        }.filter { (filterobj) -> Bool in
            let str:NSNumber! = filterobj as! NSNumber
            return str.integerValue > 3
        }.subscribeNext { (nextobj) -> Void in
            print("map->filter->subnext: \(nextobj)")
        }
        
        self.txt_password.rac_textSignal().map { (obj) -> AnyObject! in
            let text:NSString? = obj as?NSString
            return text?.length
        }.subscribeNext { (sublength) -> Void in
            let strlen:NSNumber! = sublength as! NSNumber
            if strlen.integerValue < 6
            {
                self.txt_password.backgroundColor = UIColor.clearColor()
            }
            else
            {
                self.txt_password.backgroundColor = UIColor.yellowColor()
            } 
        }
        //创建有效的状态信号
        let validPasswordSignal:RACSignal! = self.txt_password.rac_textSignal().map { (obj) -> AnyObject! in
            let text:NSString! = obj as? NSString
            return self.isValidPassword(text)
        }
        //创建密码输入框状态变化
        
        
        //创建账号输入框状态变化
        let validUsernameSignal:RACSignal! = self.txt_account.rac_textSignal().map { (obj) -> AnyObject! in
            let text:NSString! = obj as? NSString
            return self.isValidUsername(text)
        }
        
        validUsernameSignal.map { (isvalide) -> AnyObject! in
            let valide:Bool? = isvalide as? Bool
            return valide == false ? UIColor.clearColor(): UIColor.yellowColor()
        }
            .subscribeNext { (bacgroundcolor ) -> Void in
            let color:UIColor? = bacgroundcolor as? UIColor
            self.txt_account.backgroundColor = color!
        }
        
        
        var signUpActiveSignal:RACSignal! = RACSignal.combineLatest([validUsernameSignal,validPasswordSignal])
        
       //var blockProperty : (Int,Int) -> String = {a,b in return ""/**/} // 带初始化方式
        
//        signUpActiveSignal.reduceEach(reduceBlock:
//            {
//                (isuservalid:Bool?, ispasswordvalid:Bool?) -> Bool! in
//                return false
//                });
//       { (isuservalid:Bool?, ispasswordvalid:Bool?) -> Bool! in
//            return false
//            }
        
    
    }
    
    func isValidUsername( text : NSString )->Bool
    {
        return text.length > 3 ? true : false;
    }
    
    func isValidPassword( text: NSString )->Bool
    {
        return text.length > 3 ? true : false;
    }
    
    @IBAction func login(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
 
    func viewTap( gesture : UIGestureRecognizer )
    {
        self.txt_account.resignFirstResponder()
        self.txt_password.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
