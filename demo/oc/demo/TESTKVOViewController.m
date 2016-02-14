//
//  TESTKVOViewController.m
//  demo
//
//  Created by zeno on 16/2/1.
//  Copyright © 2016年 nonato. All rights reserved.
//

#import "FBKVOController.h"
#import "TestKVODetailViewController.h"
#import "TESTKVOViewController.h"
#import "HBKit.h"
@interface TESTKVOViewController ()
{
    FBKVOController *_KVOController1;
}
AS_CELL_STRUCT_COMMON(cell0)
@end

@implementation TESTKVOViewController
GET_CELL_STRUCT_WITH(cell0, 0)


GET_CELL_SELECT_ACTION(cellstruct)
{
    TestKVODetailViewController * ctr = [TestKVODetailViewController new];
    [ctr setValue:cellstruct.title forKey:@"tapcount"];// = cellstruct.title;

    // create KVO controller instance
    _KVOController1 = [FBKVOController controllerWithObserver:self];
    
    // handle clock change, including initial value
    [_KVOController1 observe:ctr keyPath:@"tapcount" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id observer, TestKVODetailViewController *object, NSDictionary *change) {
        NSString * string =  change[NSKeyValueChangeNewKey]; //[NSString stringWithFormat:@"%@",object.tapcount];
        [self.cell_struct_cell0 setTitle:string];
        [self.tableView reloadData];
    }];
    
 
    
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataDictionary setObject:self.cell_struct_cell0 forKey:KEY_INDEXPATH(0, 0)];
    
    
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
