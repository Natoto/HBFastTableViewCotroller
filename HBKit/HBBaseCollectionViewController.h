//
//  BaseCollectionViewController.h
//  PENG
//
//  Created by zeno on 15/11/18.
//  Copyright © 2015年 nonato. All rights reserved.
//
#import "HBCollectionFallFLayout.h"
#import "HBBaseViewController.h"

#warning 使用之前注册collection cell
/*
注册collection NIB CELL
 */
#define COLLECTIONVIEW_REGISTER_XIB_CELLCLASS(COLLECTIONVIEW,CELLCLSSTR)  [COLLECTIONVIEW registerNib:[UINib nibWithNibName:CELLCLSSTR bundle:nil] forCellWithReuseIdentifier:CELLCLSSTR];
/*
 注册collection Cell class
 */
#define COLLECTIONVIEW_REGISTER_CELLCLASS(COLLECTIONVIEW,CELLCLSSTR) \
[COLLECTIONVIEW registerClass:NSClassFromString(CELLCLSSTR) forCellWithReuseIdentifier:CELLCLSSTR];

@protocol HBCollectionViewControllerConfig <NSObject>
@required
/**
 *  自己配置列数量需要对其重写
 *
 *  @return columnCount
 */
#warning  配置列数量 子类需要对其重载
-(NSInteger)configColumnCount;
//配置偏移量需要重载
-(UIEdgeInsets)configSectionInset;
@end

@interface HBBaseCollectionViewController : HBBaseViewController<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,HBCollectionViewControllerConfig>

@property (nonatomic,strong ) NSMutableDictionary       * dataDictionary;
@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) HBCollectionFallFLayout   *collectionViewFlowLayout;


@property (nonatomic, assign         ) BOOL    nodeselectRow;
@property (nonatomic, assign,readonly) CGFloat itemWidth;

#if USE_MJREFRESH //是否需要用到MJRefresh
//上下拉要用到的
@property (nonatomic, assign         ) BOOL    noFooterView;
@property (nonatomic, assign         ) BOOL    noHeaderFreshView;
//调用上下拉需要的
-(void)refreshView;
-(void)getNextPageView;
-(void)FinishedLoadData;
#endif

-(void)viewDidCurrentView;
-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom;

@end
