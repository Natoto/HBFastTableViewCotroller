
//
//  TestDrawCellViewController.m
//  demo
//
//  Created by zeno on 16/2/2.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import "TestDrawCellViewController.h"
#import "DrawCell.h"
#import "HBKit.h"
@interface TestDrawCellViewController ()

@end

@implementation TestDrawCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int index = 0; index < 100; index++) {
        CELL_STRUCT * cellstruct = [CELL_STRUCT cell_x_x_struct:[NSString stringWithFormat:@"row %d",index] detailvalue:nil target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
        cellstruct.cellclass = @"DrawCell";
        cellstruct.cellheight = 80.;
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
    }
    
}

GET_CELL_SELECT_ACTION(cellstruct)
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
