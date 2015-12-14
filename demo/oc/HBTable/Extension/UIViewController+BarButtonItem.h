//
//  UIViewController+BarButtonItem.h
//  JXL
//
//  Created by 星盛 on 15/4/14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(BarButtonItem)

-(void)setleftBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;
-(void)setleftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

-(void)setrightBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;
-(void)setrightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

-(void)setnavigationItemTitleView:(UIView *)view;
-(void)setnavigationItemTitle:(NSString *)title;
@end
