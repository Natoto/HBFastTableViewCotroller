//
//  TESTXIBViewController.m
//  demo
//
//  Created by HUANGBO on 15/8/11.
//  Copyright (c) 2015年 YY.COM All rights reserved.
//

//#import "HBCellStruct.h"
#import <HBTesterKit/HBTesterKit.h>//"HBKit.h"
#import "TESTXIBViewController.h"

#import "CF_SupporterTableViewCell.h"
#import "CF_CrowdFoundHeaderCell.h"
#import "HBCellStruct_Common.h"


@interface TESTXIBViewController ()
 @property(nonatomic,retain) HBCellStruct * cell_struct_sub1;
 @property(nonatomic,retain) HBCellStruct * cell_struct_sub2;
@end

@implementation TESTXIBViewController
-(CELL_STRUCT *)cell_struct_sub1
{\
    if (!_cell_struct_sub1) {\
        _cell_struct_sub1 = [[CELL_STRUCT alloc] init];//[HBCellStruct cell_x_x_struct:@" " detailvalue:nil target:self selectAction:@selector(selectAction:)];
    }\
    return _cell_struct_sub1;\
}
-(CELL_STRUCT *)cell_struct_sub2\
{\
    if (!_cell_struct_sub2) {\
        _cell_struct_sub2 = [CELL_STRUCT cell_x_x_struct:@" " detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_sub2;\
}

 -(IBAction)selectAction:(HBCellStruct *)cellstruct
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"CF_SupporterTableViewCell");
    TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, @"CF_CrowdFoundHeaderCell");
    
    [self cellstructDataChange];
    [self.dataDictionary setObject:self.cell_struct_sub1 forKey:KEY_INDEXPATH(0, 0)];
    [self.dataDictionary setObject:self.cell_struct_sub2 forKey:KEY_INDEXPATH(0, 1)];
    
    // Do any additional setup after loading the view.
}

-(void)cellstructDataChange
{
    self.cell_struct_sub1.cellclass = @"CF_SupporterTableViewCell";
    self.cell_struct_sub1.cellheight = [self.tableView hb_heightForCellWithIdentifier:@"CF_SupporterTableViewCell" configuration:^(id cell) {
    }];//auto
    self.cell_struct_sub1.xibvalue = @"xib";//must need
    
    
    self.cell_struct_sub2.cellclass = @"CF_CrowdFoundHeaderCell";
    self.cell_struct_sub2.cellheight = [CF_CrowdFoundHeaderCell heightOfCell];
    self.cell_struct_sub2.xibvalue = @"xib";//must need
    self.cell_struct_sub2.accessory = NO;
    self.cell_struct_sub2.selectionStyle = NO;
    
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
