//
//  TestPlistCollectionViewController.m
//  demo
//
//  Created by BooB on 16/3/19.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import "TestPlistCollectionViewController.h" 
@interface TestPlistCollectionViewController ()

@end

@implementation TestPlistCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self loadplistConfig:@"TestPlistViewCollection"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)collectionView:(UICollectionView *)collectionView ColumnCountOfSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 1;
//    }
//    return 2;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
