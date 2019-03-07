//
//  HBBaseCollectionView.h
//  HBKit
//
//  Created by boob on 2017/9/22.
//

#import "HBCollectionFallFLayout.h"
#import <UIKit/UIKit.h>
#import "HBCProtocol.h"

@interface HBBaseCollectionView : UIView<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,HBCollectionViewControllerConfig,HBWaterFLayoutDelegate>

@property (nonatomic, strong) NSMutableDictionary * dataDictionary;

@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) HBCollectionFallFLayout   *collectionViewFlowLayout;


@property (nonatomic, assign         ) BOOL    nodeselectRow;
@property (nonatomic, assign,readonly) CGFloat itemWidth;


-(void)viewDidCurrentView;
-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom; 

@end
