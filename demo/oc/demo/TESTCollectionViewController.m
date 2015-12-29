//
//  TESTCollectionViewController.m
//  demo
//
//  Created by zeno on 15/12/14.
//  Copyright © 2015年 nonato. All rights reserved.
//
#import "CELL_STRUCT_Common.h"
#import "TESTCollectionViewController.h"
#import "TestCollectionViewCell.h"

@interface TESTCollectionViewController ()<HBCollectionViewControllerConfig>

@end

@implementation TESTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    COLLECTIONVIEW_REGISTER_XIB_CELLCLASS(self.collectionView, @"TestCollectionViewCell");
    for (int index = 0; index < 50; index ++) {
        CELL_STRUCT * cellstruct = [CELL_STRUCT cell_x_x_struct:@"" detailvalue:@"" target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
        cellstruct.cellclass = @"TestCollectionViewCell";
        cellstruct.xibvalue = @"xib";
        cellstruct.cellheight = 10*(index%5) + 50;
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
    }
    [self adjustContentOffSet:0 bottom:64.];
}

-(NSInteger)configColumnCount
{
    return 2;
}

-(UIEdgeInsets)configSectionInset
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}


GET_CELL_SELECT_ACTION(cellstruct)
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
