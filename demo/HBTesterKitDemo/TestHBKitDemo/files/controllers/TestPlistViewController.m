//
//  TestPlistViewController.m
//  TestHBKitDemo
//
//  Created by boob on 2017/12/19.
//  Copyright © 2017年 YY.COM. All rights reserved.
//

#import "TestPlistViewController.h"
#import "HBBaseViewController+DirWatchDog.h"

@interface TestPlistViewController ()

@end

@implementation TestPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadplistConfig:@"TestPlist" watch_directory:@"resource"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
