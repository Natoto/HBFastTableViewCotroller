//
//  HBKitRefresh.m
//  Pods
//
//  Created by HUANGBO on 16/11/29.
//
//

#import "HBKitRefresh.h"
#import <objc/runtime.h>

static char const key_hb_noHeaderFreshView = 'h';
static char const key_hb_noFooterView = 'f';

#ifndef	weakify
#if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else	// #if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	weakify

#ifndef	strongify
#if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
#else	// #if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	@normalize


@implementation HBBaseTableViewController(HBKitRefresh)
//@dynamic noHeaderFreshView;
//@dynamic noFooterView;
//
-(BOOL)noHeaderFreshView{
   NSNumber * hf = objc_getAssociatedObject(self, &key_hb_noHeaderFreshView);
    hf = hf?hf:@1;
    return hf.boolValue;
}

-(BOOL)noFooterView{
    NSNumber * hf = objc_getAssociatedObject(self, &key_hb_noFooterView);
    hf = hf?hf:@1;
    return hf.boolValue;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的refreshView)
    self.noHeaderFreshView = YES;
    [self.tableView.header beginRefreshing];
    self.noFooterView = YES;
}
-(void)setNoHeaderFreshView:(BOOL)noHeaderFreshView
{
     objc_setAssociatedObject(self, &key_hb_noHeaderFreshView, @(noHeaderFreshView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    _noHeaderFreshView = noHeaderFreshView;
    if (noHeaderFreshView) {
        [self.tableView.header removeFromSuperview];
    }
    else
    {
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshView)];
    }
}

-(void)setNoFooterView:(BOOL)noFooterView
{
//    _noFooterView = noFooterView;
     objc_setAssociatedObject(self, &key_hb_noFooterView, @(noFooterView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (noFooterView) {
        [self.tableView.footer removeFromSuperview];
    }
    else
    {
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNextPageView)];
    }
}

-(void)refreshView{}
-(void)removeFooterView{}
-(void)setFooterView{}

//调用上下拉需要的

//加载调用的方法
-(void)getNextPageView{}

-(void)startHeaderLoading
{
    [self.tableView.header beginRefreshing];
}
-(void)FinishedLoadData
{
    [self.tableView.header  endRefreshing];
    [self.tableView.footer endRefreshing];
}

-(void)noMore
{
    [self.tableView removeFromSuperview];
}

-(void)finishReloadingData
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}
@end



@implementation HBBaseCollectionViewController(HBKitRefresh)

//@dynamic noHeaderFreshView;
//@dynamic noFooterView;

-(BOOL)noHeaderFreshView{
    NSNumber * hf = objc_getAssociatedObject(self, &key_hb_noHeaderFreshView);
    hf = hf?hf:@1;
    return hf.boolValue;
}

-(BOOL)noFooterView{
    NSNumber * hf = objc_getAssociatedObject(self, &key_hb_noFooterView);
    hf = hf?hf:@1;
    return hf.boolValue;
}

-(void)setNoHeaderFreshView:(BOOL)noHeaderFreshView
{
      objc_setAssociatedObject(self, &key_hb_noHeaderFreshView, @(noHeaderFreshView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!noHeaderFreshView) { @weakify(self);
        self.collectionView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            @strongify(self)
            [self refreshView];
        }];
    }
}

-(void)setNoFooterView:(BOOL)noFooterView
{
     objc_setAssociatedObject(self, &key_hb_noFooterView, @(noFooterView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!noFooterView) {
        @weakify(self);
        self.collectionView.footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{@strongify(self)
            [self getNextPageView];
        }];
    }
    else
    {
        self.collectionView.footer = nil;
    }
}

-(void)refreshView{}
-(void)getNextPageView{}
-(void)FinishedLoadData{
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
}

@end


