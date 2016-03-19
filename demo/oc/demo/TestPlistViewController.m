//
//  TestPlistViewController.m
//  demo
//
//  Created by zeno on 16/3/17.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import "TestPlistViewController.h"

@interface TestPlistViewController ()

@end

@implementation TestPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadplistConfig:@"TestPlistViewCollection"];
    NSLog(@"%@",self.dataDictionary);
    
    // Do any additional setup after loading the view.
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
