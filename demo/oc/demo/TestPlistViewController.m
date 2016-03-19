//
//  TestPlistViewController.m
//  demo
//
//  Created by zeno on 16/3/17.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import "TestPlistCollectionViewController.h"
#import "TestPlistViewController.h"
#import "CELL_STRUCT_Common.h"
@interface TestPlistViewController ()

@end

@implementation TestPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadplistConfig:@"TestPlistViewController"];
    NSLog(@"%@",self.dataDictionary);
    
    // Do any additional setup after loading the view.
}

GET_CELL_SELECT_ACTION(cellstruct)
{
    TestPlistCollectionViewController * ctr = [TestPlistCollectionViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
