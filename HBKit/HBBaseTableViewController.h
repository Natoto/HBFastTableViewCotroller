//
//  BaseTableViewController.h
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBBaseTableViewCell.h" 
#import "HBBaseViewController.h" 
#import "CELL_STRUCT_Common.h"

//#if __has_include(<MJRefresh/MJRefresh.h>)


static NSString * notify_basetableview_tap = @"basetableview_tap";
static NSString * notify_basetableview_sender = @"BaseViewController";
static int TAG_TABLEVIEW = 1521;

//注册cell
#define TABLEVIEW_REGISTERXIBCELL_CLASS(TABLEVIEW,CELLCLSSTR) {[TABLEVIEW registerClass:NSClassFromString(CELLCLSSTR) forCellReuseIdentifier:CELLCLSSTR];\
[TABLEVIEW registerNib:[UINib nibWithNibName:CELLCLSSTR bundle:nil] forCellReuseIdentifier:CELLCLSSTR];}


#undef TABLEVIEW_REGISTER_CELLCLASS
#define TABLEVIEW_REGISTER_CELLCLASS(TABLEVIEW,CELLCLSSTR) {[TABLEVIEW registerClass:NSClassFromString(CELLCLSSTR) forCellReuseIdentifier:CELLCLSSTR];}

#undef TABLEVIEW_CELL_SEPARATOR_NONE
#define TABLEVIEW_CELL_SEPARATOR_NONE self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

@interface HBBaseTableViewController : HBBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView               * tableView;
//不自动配置tableview
@property (nonatomic, assign) BOOL                       noAutoConfigTableView;
//点击之后不自动变回未选状态
@property (nonatomic, assign) BOOL                       nodeselectRow;



-(void)viewDidCurrentView;

-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom;
 
-(void)observeTapgesture;

//配置tableview 一般情况下自动配置 配合 noautoconfigtableview 使用
-(void)configTableView;

/**
 * 配置顶部navigationbar 和 tableview的位置
 */
-(void)TableViewDefaultConfigWithTitle:(NSString *)title;

/**
 * 使用默认配置 供子类调用
 */
-(void)userDefaultConfigWithTitle:(NSString *)title;

/**
 * 根据keyindexpath 刷新该cell
 */
-(void)reloadTableViewCellWithKeyindexpath:(NSString *)keyindexpath;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;


-(HBBaseTableViewCell *)getcellWithIndexPath:(NSIndexPath *)indexPath;
////是否需要用到MJRefresh
////上下拉要用到的
//@property (nonatomic, assign) BOOL                       noFooterView;
//@property (nonatomic, assign) BOOL                       noHeaderFreshView;
@end


@interface  UITableView (HBTemplateLayoutCell)

/**
 *  计算CELL的高度 实现的方法需要在cell的具体实现里面重载sizeThatFit:
 *
 *  @param identifier    identifier
 *  @param configuration cell加载数据的
 *
 *  @return 高度
 */
- (CGFloat)hb_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration;
@end

