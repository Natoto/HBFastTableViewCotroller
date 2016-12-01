//
//  TestKVODetailViewController.m
//  demo
//
//  Created by zeno on 16/2/1.
//  Copyright © 2016年 YY.COM All rights reserved.
//

#import "TestKVODetailViewController.h"

@interface TestKVODetailViewController ()

@property (strong, readwrite, nonatomic) NSString *tapcount;
@end

@implementation TestKVODetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:self.tapcount forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 150, 50);
    button.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(IBAction)buttonTap:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString *string = button.titleLabel.text;
    string = [NSString stringWithFormat:@"%d",string.intValue + 1];
    [button setTitle:string forState:UIControlStateNormal];
//    [self setValue:string forKey:@"tapcount"];
    self.tapcount = string;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
