//
//  TestPlistCollectionViewController.m
//  demo
//
//  Created by BooB on 16/3/19.
//  Copyright © 2016年 YY.COM All rights reserved.
//

#import "TestPlistCollectionViewController.h" 
@interface TestPlistCollectionViewController ()

@end

@implementation TestPlistCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    COLLECTIONVIEW_REGISTER_XIB_CELLCLASS(self.collectionView, @"BaseXIBCollectionViewCell");
    [self loadplistConfig:@"TestPlistViewCollection"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
