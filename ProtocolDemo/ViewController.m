//
//  ViewController.m
//  ProtocolDemo
//
//  Created by BooB on 15/8/8.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "ViewController.h"
#import "CELL_STRUCT_Common.h"
#import "CELL_STRUCT.h"

@interface ViewController ()
AS_CELL_STRUCT_JXLCOMMON(cell00)
AS_CELL_STRUCT_JXLCOMMON(cell01)
@end

@implementation ViewController
GET_CELL_STRUCT_WITH(cell00, cell00)
GET_CELL_STRUCT_WITH(cell01, cell01)


GET_CELL_SELECT_ACTION(cellstruct)
{
    NSLog(@"%@ 点击",cellstruct.title);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataDictionary setObject:self.cell_struct_cell00 forKey:KEY_INDEXPATH(0, 0)];
    [self.dataDictionary setObject:self.cell_struct_cell01 forKey:KEY_INDEXPATH(0, 1)];
    
    for (int INDEX = 0; INDEX < 50; INDEX ++) {
        CELL_STRUCT * cellstruct = [CELL_STRUCT_Common cell_x_x_struct:[NSString stringWithFormat:@"row %d",INDEX] detailvalue:nil target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(1, INDEX)];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
