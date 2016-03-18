//
//  ViewController.m
//  demo
//
//  Created by 跑酷 on 15/8/11.
//  Copyright (c) 2015年 nonato. All rights reserved.
//
#import "TESTSystyleviewController.h"
#import "ViewController.h"
#import "HBKit.h"
#import "TESTXIBViewController.h"
#import "TESTAutoHeightViewController.h"
#import "TESTRefreshViewController.h"
#import "TESTCollectionViewController.h"
#import "NormalTableViewController.h"
#import "NormalCollectionViewController.h"
#import "TESTKVOViewController.h"
#import "TestDrawCellViewController.h"
#import "TestPlistViewController.h"

#import "AppDelegate.h"
@interface ViewController ()
//step 1
AS_CELL_STRUCT_COMMON(normal)
AS_CELL_STRUCT_COMMON(sys)
AS_CELL_STRUCT_COMMON(xib)
AS_CELL_STRUCT_COMMON(plist)
AS_CELL_STRUCT_COMMON(autoheight)
AS_CELL_STRUCT_COMMON(refresh)
AS_CELL_STRUCT_COMMON(normalcollection)
AS_CELL_STRUCT_COMMON(collection)
AS_CELL_STRUCT_COMMON(kvo)
AS_CELL_STRUCT_COMMON(drawcell)

@end

@implementation ViewController
//step 2
GET_CELL_STRUCT_WITH(normal, 普通的列表写法)
GET_CELL_STRUCT_WITH(sys, HBTABLE-系统控件)
GET_CELL_STRUCT_WITH(xib, HBTABLE-加载XIB)
GET_CELL_STRUCT_WITH(plist, load plist)
GET_CELL_STRUCT_WITH(autoheight, HBTABLE-自动高度)
GET_CELL_STRUCT_WITH(refresh, HBTABLE-上下拉)
GET_CELL_STRUCT_WITH(normalcollection,普通COLLECTIONVIEW)
GET_CELL_STRUCT_WITH(collection, COLLECTION-加载);
GET_CELL_STRUCT_WITH(kvo, KVO)
GET_CELL_STRUCT_WITH(drawcell, Drawcell)
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HBTABLE";
    NSInteger rowIndex = 0;
    NSInteger sectionIndex = 0;
    
    [self.cell_struct_normal.dictionary setObject:@"0x33ffee" forKey:key_cellstruct_background];
    [self.cell_struct_sys.dictionary setObject:@"0XDABF4A" forKey:key_cellstruct_background];
    
    
    [self.dataDictionary setObject:self.cell_struct_normal forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_sys forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_xib forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_plist forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_autoheight forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_refresh forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_normalcollection forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
   [self.dataDictionary setObject:self.cell_struct_collection forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
 
    self.view.backgroundColor =  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    self.tableView.backgroundColor = self.view.backgroundColor;
 
    
    sectionIndex++;
    rowIndex = 0;
    self.cell_struct_kvo.sectionheight = 20;
   [self.dataDictionary setObject:self.cell_struct_kvo forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
   [self.dataDictionary setObject:self.cell_struct_drawcell forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];

}

/**
 *  响应的CELselect的方法
 */
//step 3
GET_CELL_SELECT_ACTION(cellstruct)
{
    if(cellstruct == self.cell_struct_sys)
    {
        
//        CATransition *transition = [CATransition animation];
//        transition.duration = 1;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        transition.type = @"oglFlip";
//        transition.subtype = kCATransitionFromTop;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        TESTSystyleviewController * ctr = [[TESTSystyleviewController alloc] init];
        
        ctr.modalPresentationStyle= UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;//if the controller has container like navigationcontroller or tababr controlelr,if you don`t use the UIModalPresentationFullScreen the bar will cover the viewcontroller
        UINavigationController * navictr = [[UINavigationController alloc] initWithRootViewController:ctr];
         navictr.modalPresentationStyle= UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
        [self presentViewController:navictr animated:NO completion:^{
        }];
//        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_xib)
    {
        TESTXIBViewController * ctr = [[TESTXIBViewController alloc] init];

        
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_autoheight)
    {
        TESTAutoHeightViewController * ctr =[[TESTAutoHeightViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_refresh)
    {
        TESTRefreshViewController * ctr =[[TESTRefreshViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_collection)
    {
        TESTCollectionViewController * ctr = [[TESTCollectionViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_normal)
    {
        NormalTableViewController * ctr =[NormalTableViewController new];
        [self.navigationController   pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_normalcollection)
    {
        NormalCollectionViewController * ctr = [NormalCollectionViewController new];
        [self.navigationController   pushViewController:ctr animated:YES];
    }
    else if (cellstruct == self.cell_struct_kvo)
    {
        TESTKVOViewController * ctr = [TESTKVOViewController new];
        [self.navigationController   pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_drawcell)
    {
        TestDrawCellViewController * ctr = [TestDrawCellViewController new];
        [self.navigationController   pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_plist)
    {
        TestPlistViewController * ctr = [TestPlistViewController new];
        [self.navigationController   pushViewController:ctr animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
