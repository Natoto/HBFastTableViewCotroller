//
//  ViewController.m
//  demo
//
//  Created by 跑酷 on 15/8/11.
//  Copyright (c) 2015年 nonato. All rights reserved.
//
#import "SystyleviewController.h"
#import "ViewController.h"
#import "HBTable.h"
#import "TESTXIBViewController.h"

@interface ViewController ()
//step 1
AS_CELL_STRUCT_COMMON(sys)
AS_CELL_STRUCT_COMMON(xib)
AS_CELL_STRUCT_COMMON(autoheight)
AS_CELL_STRUCT_COMMON(refresh)

@end

@implementation ViewController
//step 2
GET_CELL_STRUCT_WITH(sys, HBTABLE-系统控件)
GET_CELL_STRUCT_WITH(xib, HBTABLE-加载XIB)
GET_CELL_STRUCT_WITH(autoheight, HBTABLE-自动高度)
GET_CELL_STRUCT_WITH(refresh, HBTABLE-上下拉)

/**
 *  响应的CELselect的方法
 */
//step 3
GET_CELL_SELECT_ACTION(cellstruct)
{
    if(cellstruct == self.cell_struct_sys)
    {
        SystyleviewController * ctr = [[SystyleviewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_xib)
    {
        TESTXIBViewController * ctr = [[TESTXIBViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HBTABLE";
    NSInteger rowIndex = 0;
    [self.dataDictionary setObject:self.cell_struct_sys forKey:KEY_INDEXPATH(0, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_xib forKey:KEY_INDEXPATH(0, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_autoheight forKey:KEY_INDEXPATH(0, rowIndex++)];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
