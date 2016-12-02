//
//  TestJsonViewController.m
//  demo
//
//  Created by HUANGBO on 16/5/24.
//  Copyright © 2016年 YY.COM All rights reserved.
//

#import "TestJsonViewController.h"
#import <HBKit/HBKit.h>
#import <HBKitWatchDog/HBKitWatchDog.h>

@interface TestJsonViewController ()

@end

@implementation TestJsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    [self loadjsonfileConfig:@"TestJson" ];
    [self loadjsonfileConfig:@"TestJson" watch_directory:@"resource"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)jsonstring
{
    NSString * filepath = [[NSBundle mainBundle] pathForResource:@"TestJson" ofType:@"json"];
    NSError * error;
    NSString * string = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    if(error) { // If error object was instantiated, handle it.
        NSLog(@"ERROR while loading from file: %@", error);
        // …
    }
    return string; 
}
@end
