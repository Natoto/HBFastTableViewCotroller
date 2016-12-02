//
//  TestPlistViewController.m
//  demo
//
//  Created by zeno on 16/3/17.
//  Copyright © 2016年 YY.COM All rights reserved.
//

#import "TestPlistCollectionViewController.h"
#import "TestPlistViewController.h"
#import "CELL_STRUCT_Common.h"
#import <HBKitWatchDog/HBKitWatchDog.h>
@interface TestPlistViewController ()

@end

@implementation TestPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TABLEVIEW_CELL_SEPARATOR_NONE
    
    [self loadplistConfig:@"Testplistvc" watch_directory:@"resource"];
    
//    [self loadplistConfig:@"TestPlistViewController" filepath: [[NSBundle mainBundle] pathForResource:@"TestPlistViewController" ofType:@"plist" inDirectory:@"resource"]];
//    NSLog(@"%@",self.dataDictionary);
//    
    // Do any additional setup after loading the view.
}

 -(IBAction)selectAction:(HBCellStruct *)cellstruct
{
    TestPlistCollectionViewController * ctr = [TestPlistCollectionViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
