//
//       _      ______
//	/\ _\ \    /\  __ \
//	\   _  \   \ \  __<
//	 \ \  \ \   \ \_____\
//	  \/   \/    \/_____/
//
//
//
//  Created by boob on 16/4/22.
//  Copyright © 2016年 YY.COM All rights reserved.
//

#import "testhb.h"
@interface testhb ()
#pragma mark- as

#pragma mark- model


@end

@implementation testhb

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configcellstructs];
    //注册cellclase：  TABLEVIEW_REGISTERXIBCELL_CLASS(TABLEVIEW,CELLCLSSTR)
    
}


// 配置cellstructs
- (void)configcellstructs
{
    
}


#pragma mark - api
//下拉刷新
-(void)refreshView
{
    
}

//上拉更多
-(void)getNextPageView
{
    
}

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event

#pragma mark 1 target-action
#pragma mark - 响应Cell点击


GET_CELL_SELECT_ACTION(cellstruct)
{
    
}

#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -

@end
