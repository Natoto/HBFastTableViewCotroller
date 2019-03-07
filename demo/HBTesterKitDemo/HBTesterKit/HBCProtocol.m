//
//  HBCProtocol.m
//  HBKit
//
//  Created by boob on 2017/9/22.
//

#import "HBCProtocol.h"
#import "HBCollectionFallFLayout.h"
#import "HBBaseCollectionViewCell.h"
#import "HBBaseSectionCollectionReusableView.h"
#import "HBCellStruct.h"
#import "HBCellStruct_KEY.h"
#import "HBCellStruct_Common.h"

@implementation HBCProtocol





+ (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath background:(UIColor *)backgroundColor dataDictionary:(NSMutableDictionary *)dataDictionary
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        HBBaseSectionCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HBBaseSectionCollectionReusableView" forIndexPath:indexPath];
        CELL_STRUCT *cell_struce = [dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, 0)];
        
        view.titleLabel.text = cell_struce.sectiontitle;
        CGFloat sectionfont = (cell_struce.sectionfont > 0)?cell_struce.sectionfont:12;
        view.titleLabel.font = [UIFont systemFontOfSize:sectionfont];
        view.titleLabel.textColor = [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectioncolor];
        view.titleLabel.textAlignment = NSTextAlignmentLeft;
        UIColor * bgcolor =  [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectionbgcolor];
        view.backgroundColor =  bgcolor?bgcolor:backgroundColor;
        
        return view;
    }
    return nil;
}

+(UICollectionView *)createCollectionView:(id<HBCollectionViewControllerConfig,HBWaterFLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>)target frame:(CGRect)frame{
    
    CGRect collectionViewFrame = frame;
    HBCollectionFallFLayout *collectionViewFlowLayout = [[HBCollectionFallFLayout alloc] init];
    collectionViewFlowLayout.delegate = target;
    collectionViewFlowLayout.headerHeight = 0;
    collectionViewFlowLayout.minimumColumnSpacing = target.configMinimumColumnSpacing;
    collectionViewFlowLayout.minimumInteritemSpacing = target.configMinimumInteritemSpacing;
    collectionViewFlowLayout.sectionInset = target.configSectionInset;
    collectionViewFlowLayout.columnCount = target.configColumnCount;

    target.collectionViewFlowLayout = collectionViewFlowLayout;
    UICollectionView * _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:collectionViewFlowLayout];
    _collectionView.dataSource = target;
    _collectionView.delegate = target;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.contentInset = UIEdgeInsetsMake(64., 0, 0, 0);
    [_collectionView registerClass:[HBBaseCollectionViewCell class] forCellWithReuseIdentifier:@"HBBaseCollectionViewCell"];
    [_collectionView registerClass:[HBBaseSectionCollectionReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"HBBaseSectionCollectionReusableView"];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        return _collectionView;

    
}
@end
