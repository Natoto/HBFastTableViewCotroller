//
//  TESTRefreshViewController.m
//  demo
//
//  Created by 跑酷 on 15/8/11.
//  Copyright (c) 2015年 nonato. All rights reserved.
//
#import "HBTable.h"
#import "TESTRefreshViewController.h"

//上下拉需要解开
//#define USERMJREFRESH 1 //0不用到MJRefresh 1 用到了MJRefresh
@interface TESTRefreshViewController ()

@end

@implementation TESTRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noHeaderFreshView = NO;
    self.noFooterView = NO;
    [self refreshView];
}

-(void)refreshView
{
    [self.dataDictionary removeAllObjects];
    for (int index = 0; index < 10; index ++) {
        NSString * string = [NSString stringWithFormat:@"cell %d",index];
        CELL_STRUCT * cellstruct = [self createcellstruct:string];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
    }
    [self performSelector:@selector(FinishedLoadData) withObject:nil afterDelay:2];
    [self.tableView reloadData];
}

-(void)getNextPageView
{
    const int startIndex = (int)self.dataDictionary.count-1;
    for (int index = startIndex  ; index < startIndex + 10; index ++) {
        NSString * string = [NSString stringWithFormat:@"cell %d",index];
        CELL_STRUCT * cellstruct = [self createcellstruct:string];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
    }
    [self performSelector:@selector(FinishedLoadData) withObject:nil afterDelay:2];
    [self.tableView reloadData];
}
GET_CELL_SELECT_ACTION(cellstruct)
{
    
}
-(CELL_STRUCT *)createcellstruct:(NSString *)title
{
    CELL_STRUCT * cellstruct = [CELL_STRUCT_Common cell_x_x_struct:title detailvalue:nil target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
    return cellstruct;
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
