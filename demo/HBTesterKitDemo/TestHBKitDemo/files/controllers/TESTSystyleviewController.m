//
//  SystyleviewController.m
//  demo
//
//  Created by HUANGBO on 15/8/11.
//  Copyright (c) 2015年 YY.COM All rights reserved.
//

#import "TESTSystyleviewController.h"
#import "HBTesterKit.h"
//随机颜色

#undef HBRandomColor
#define HBRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface TESTSystyleviewController ()

@end

@implementation TESTSystyleviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统TABLE STYLE";
    for (int index = 0; index < 10; index ++) {
        NSString * title = [NSString stringWithFormat:@"cell %d",index];
        NSString * detail = [NSString stringWithFormat:@"detail cell %d",index];
        CELL_STRUCT * cellstruct = [self createcellstruct:title detail:detail index:index];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
    }
    
    for (int index = 0; index < 10; index ++) {
        NSString * title = [NSString stringWithFormat:@"cell %d",index];
        NSString * detail = [NSString stringWithFormat:@"detail cell %d",index];
        CELL_STRUCT * cellstruct = [self createcellstruct:title detail:detail index:index];
        cellstruct.sectiontitle = [NSString stringWithFormat:@"SECTION 1"];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(1, index)];
    }
    self.showBackItem = YES;
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = self.view.backgroundColor;
    // Do any additional setup after loading the view.
}

-(CELL_STRUCT *)createcellstruct:(NSString *)title detail:(NSString *)detail index:(int)index
{
    CELL_STRUCT * cellstruct = [CELL_STRUCT_Common cell_x_x_struct:title detailvalue:detail target:self selectAction:@selector(cellselect:)];
    cellstruct.sectionheight = 40;
    cellstruct.sectioncolor = value_cellstruct_blue;
    cellstruct.sectiontitle = @"SECTION 0";
    cellstruct.cellheight = 60;
    cellstruct.picture = @"profile";
    cellstruct.CellStyleValue = index%3;
    cellstruct.accessory = index%2;
    cellstruct.selectionStyle = index%2;
    [cellstruct.dictionary setObject:HBRandomColor forKey:key_cellstruct_background];
    
    return cellstruct;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cellselect:(CELL_STRUCT *)cellstruct
{
   
//    TESTSystyleviewController * ctr = [[TESTSystyleviewController alloc] init];
//    ctr.modalPresentationStyle= UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;//if the controller has container like navigationcontroller or tababr controlelr,if you don`t use the UIModalPresentationFullScreen the bar will cover the viewcontroller
//    UINavigationController * navictr = [[UINavigationController alloc] initWithRootViewController:ctr];
//    navictr.modalPresentationStyle= UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
//    
//    [self presentViewController:navictr animated:NO completion:^{
//    }];
}

@end
