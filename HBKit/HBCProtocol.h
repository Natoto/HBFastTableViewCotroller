//
//  HBCProtocol.h
//  HBKit
//
//  Created by boob on 2017/9/22.
//

#import <Foundation/Foundation.h>

#warning 使用之前注册collection cell
/*
 注册collection NIB CELL
 [self.collectionView registerNib:[UINib nibWithNibName:@"BaseXIBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BaseXIBCollectionViewCell"];
 */
#define COLLECTIONVIEW_REGISTER_XIB_CELLCLASS( COLLECTIONVIEW , CELLCLSSTR )  [ COLLECTIONVIEW registerNib:[UINib nibWithNibName: CELLCLSSTR bundle:nil] forCellWithReuseIdentifier: CELLCLSSTR ];

/*
 注册SECTION header 或者 footer xib
 */
#define COLLECTIONVIEW_REGISTER_XIB_FORSUPPLEMENTARYVIEW(COLLECTIONVIEW,CELLSLSSTR) [COLLECTIONVIEW registerNib:[UINib nibWithNibName:CELLSLSSTR bundle:nil] forSupplementaryViewOfKind:CELLSLSSTR withReuseIdentifier:CELLSLSSTR];

/*
 注册SECTION header 或者 footer class 暂时有点问题 如需注册手动编写
 */
//#define COLLECTIONVIEW_REGISTER_CLASS_FORSUPPLEMENTARYVIEW(COLLECTIONVIEW,CELLSLSSTR) \
[COLLECTIONVIEW registerClass:[CELLSLSSTR class] forSupplementaryViewOfKind:CELLSLSSTR withReuseIdentifier:CELLSLSSTR];


/*
 注册collection Cell class
 */
#define COLLECTIONVIEW_REGISTER_CELLCLASS(COLLECTIONVIEW,CELLCLSSTR) \
[COLLECTIONVIEW registerClass:NSClassFromString(CELLCLSSTR) forCellWithReuseIdentifier:CELLCLSSTR];



@protocol HBCollectionViewControllerConfig <NSObject>
@required
@property (nonatomic, strong) UICollectionViewLayout * collectionViewFlowLayout;
/**
 *  自己配置列数量需要对其重写
 *
 *  @return columnCount
 */
#warning  配置列数量 子类需要对其重载
/**
 *  配置最大列的值
 *
 *  @return 列数目
 */
-(NSInteger)configColumnCount;
//配置偏移量需要重载
/**
 *  配置collectionView距上左下右的距离
 *
 *  @return  UIEdgeInsets
 */
-(UIEdgeInsets)configSectionInset;

-(UIEdgeInsets)configInsetForSectionAtIndex:(NSInteger)section;

/**
 *  配置列(左右)之间的间距
 *
 */
-(CGFloat)configMinimumColumnSpacing;
/**
 *  配置行(上下)之间的间距
 *
 *  @return 间距
 */
-(CGFloat)configMinimumInteritemSpacing;
@end

@protocol HBWaterFLayoutDelegate;

@interface HBCProtocol : NSObject



+ (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
                                  background:(UIColor *)backgroundColor
                              dataDictionary:(NSMutableDictionary *)dataDictionary;

+(UICollectionView *)createCollectionView:(id<HBCollectionViewControllerConfig,HBWaterFLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>)target frame:(CGRect)frame;

@end
