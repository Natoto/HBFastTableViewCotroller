//
//  ViewController.m
//  demo
//
//  Created by HUANGBO on 15/8/11.
//  Copyright (c) 2015年 YY.COM All rights reserved.
//
#import "TESTSystyleviewController.h"
#import "RootViewController.h"
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
#import "TestJsonViewController.h"
#import "TestAsynDisplayController.h"

#import "AppDelegate.h"
@interface RootViewController ()
//step 1
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_normal;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_sys;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_xib;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_plist;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_autoheight;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_refresh;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_normalcollection;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_collection;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_kvo;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_drawcell;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_copy;
 @property(nonatomic,retain) CELL_STRUCT * cell_struct_testjson;

@property(nonatomic,retain) CELL_STRUCT * cell_struct_testanode;

@end
@implementation RootViewController
GET_CELL_STRUCT_WITH(testanode, 测试asyndisplaynode);

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HBKit-快速开发引擎";
    [self loadCellstructConfig];
}

-(void)loadCellstructConfig{
    
    NSInteger rowIndex = 0;
    NSInteger sectionIndex = 0;
    
    self.cell_struct_normal.sectionheight = 30;
    self.cell_struct_normal.sectiontitle = @"常规列表和瀑布流创建方法";
    [self.dataDictionary setObject:self.cell_struct_normal forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_normalcollection forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    
    sectionIndex++,rowIndex = 0;
    self.cell_struct_sys.sectionheight = 20;
    self.cell_struct_sys.sectiontitle = @"HBKit列表和瀑布流创建方法";
    
    [self.dataDictionary setObject:self.cell_struct_sys forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_plist forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_testjson forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_xib forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_autoheight forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_refresh forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_testanode forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    
    
    sectionIndex++,rowIndex = 0;
    self.cell_struct_collection.sectionheight = 20;
    [self.dataDictionary setObject:self.cell_struct_collection forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    
    
    sectionIndex++,rowIndex = 0;
    self.cell_struct_kvo.sectionheight = 20;
    [self.dataDictionary setObject:self.cell_struct_kvo forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_drawcell forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    
    sectionIndex++;
    rowIndex = 0;
    [self.dataDictionary setObject:self.cell_struct_copy forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    
    [self.tableView reloadData];
}

/**
 *  响应的CELselect的方法
 */
//step 3
 -(IBAction)selectAction:(CELL_STRUCT *)cellstruct
{
    if(cellstruct == self.cell_struct_sys)
    {
        
        TESTSystyleviewController * ctr = [[TESTSystyleviewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
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
    else if (cellstruct == self.cell_struct_copy)
    {
        CELL_STRUCT * astruct = [self.cell_struct_copy copy];
        NSLog(@"%@",astruct);
    }else if(cellstruct == self.cell_struct_testjson){
        TestJsonViewController * ctr = [TestJsonViewController new]; 
        [self.navigationController   pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_testanode){
        TestAsynDisplayController * ctr = [TestAsynDisplayController new];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//step 2
-(CELL_STRUCT *)cell_struct_normal\
{\
    if (!_cell_struct_normal) {\
        _cell_struct_normal = [CELL_STRUCT cell_x_x_struct:@"普通的列表写法" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_normal;\
}
-(CELL_STRUCT *)cell_struct_sys\
{\
    if (!_cell_struct_sys) {\
        _cell_struct_sys = [CELL_STRUCT cell_x_x_struct:@"hbbasetableviewcell支持的属性" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_sys;\
}
-(CELL_STRUCT *)cell_struct_xib\
{\
    if (!_cell_struct_xib) {\
        _cell_struct_xib = [CELL_STRUCT cell_x_x_struct:@"hbkit加载xib方式" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_xib;\
}
-(CELL_STRUCT *)cell_struct_plist\
{\
    if (!_cell_struct_plist) {\
        _cell_struct_plist = [CELL_STRUCT cell_x_x_struct:@"hbkit从plist文件加载" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_plist;\
}
-(CELL_STRUCT *)cell_struct_autoheight\
{\
    if (!_cell_struct_autoheight) {\
        _cell_struct_autoheight = [CELL_STRUCT cell_x_x_struct:@"hbkit自动计算高度方式" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_autoheight;\
}
-(CELL_STRUCT *)cell_struct_refresh\
{\
    if (!_cell_struct_refresh) {\
        _cell_struct_refresh = [CELL_STRUCT cell_x_x_struct:@"hbkitrefresh上下拉刷新" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_refresh;\
}
-(CELL_STRUCT *)cell_struct_normalcollection\
{\
    if (!_cell_struct_normalcollection) {\
        _cell_struct_normalcollection = [CELL_STRUCT cell_x_x_struct:@"uicollectionview" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_normalcollection;\
}
-(CELL_STRUCT *)cell_struct_collection\
{\
    if (!_cell_struct_collection) {\
        _cell_struct_collection = [CELL_STRUCT cell_x_x_struct:@"hbbasecollectionview" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_collection;\
};
-(CELL_STRUCT *)cell_struct_kvo\
{\
    if (!_cell_struct_kvo) {\
        _cell_struct_kvo = [CELL_STRUCT cell_x_x_struct:@"cellstruct属性kvo" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_kvo;\
}
-(CELL_STRUCT *)cell_struct_drawcell\
{\
    if (!_cell_struct_drawcell) {\
        _cell_struct_drawcell = [CELL_STRUCT cell_x_x_struct:@" Drawcell" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_drawcell;\
}
-(CELL_STRUCT *)cell_struct_copy\
{\
    if (!_cell_struct_copy) {\
        _cell_struct_copy = [CELL_STRUCT cell_x_x_struct:@"cellstruct拷贝" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_copy;\
}
-(CELL_STRUCT *)cell_struct_testjson\
{\
    if (!_cell_struct_testjson) {\
        _cell_struct_testjson = [CELL_STRUCT cell_x_x_struct:@"hbkit从json文件中加载" detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_testjson;\
}

@end
