//
//  UIViewController+BarButtonItem.m
//  JXL
//
//  Created by 星盛 on 15/4/14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "UIViewController+BarButtonItem.h"
 
@implementation UIViewController(BarButtonItem)

-(void)setleftBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector
{
    UIBarButtonItem * leftbaritem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:selector];
    self.navigationItem.leftBarButtonItem = leftbaritem;
}

-(void)setleftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIBarButtonItem * leftbaritem = [[UIBarButtonItem alloc]  initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:selector];
    self.navigationItem.leftBarButtonItem = leftbaritem;
}


-(void)setrightBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector
{
    UIBarButtonItem * leftbaritem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:selector];
    self.navigationItem.rightBarButtonItem = leftbaritem;
}

-(void)setrightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIBarButtonItem * leftbaritem = [[UIBarButtonItem alloc]  initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:selector];
    self.navigationItem.rightBarButtonItem = leftbaritem;
}

-(void)setnavigationItemTitleView:(UIView *)view
{
    [self.navigationItem setTitleView:view];
}

-(void)setnavigationItemTitle:(NSString *)title
{
    [self.navigationItem setTitleView:nil];
    [self.navigationItem setTitle:title];
}


@end
