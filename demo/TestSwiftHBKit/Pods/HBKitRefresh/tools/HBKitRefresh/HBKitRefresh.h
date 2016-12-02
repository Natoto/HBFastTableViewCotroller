//
//  HBKitRefresh.h
//  Pods
//
//  Created by HUANGBO on 16/11/29.
//
//

#import <HBKit/HBKit.h>
#import <MJRefresh/MJRefresh.h>
#import "HBBaseTableViewController.h"
#import "HBBaseCollectionViewController.h"

@protocol  HBKitRefreshProtocol<NSObject>

-(void)removeFooterView;
-(void)finishReloadingData;
-(void)setFooterView;
-(void)startHeaderLoading;

//调用上下拉需要的
-(void)refreshView;
-(void)getNextPageView;
-(void)FinishedLoadData;

@end

@interface HBBaseTableViewController(HBKitRefresh)<HBKitRefreshProtocol>

@end

@interface HBBaseCollectionViewController(HBKitRefresh)<HBKitRefreshProtocol>

@end
