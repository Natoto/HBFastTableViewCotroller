//
//  BaseCollectionViewController.m
//  PENG
//
//  Created by zeno on 15/11/18.
//  Copyright © 2015年 YY.COM All rights reserved.
//

#import "HBBaseCollectionViewController.h"
#import "HBBaseCollectionViewCell.h"
#import "HBCollectionFallFLayout.h"
#import "CELL_STRUCT_Common.h"
#import "HBBaseSectionCollectionReusableView.h"


@interface HBBaseCollectionViewController ()
{
    BOOL config;
}
@end

@implementation HBBaseCollectionViewController

-(NSInteger)configColumnCount
{
    return 10;
}
-(UIEdgeInsets)configSectionInset
{
    return UIEdgeInsetsZero;
}

-(UIEdgeInsets)configInsetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(CGFloat)configMinimumColumnSpacing
{
    return 5.;
}

-(CGFloat)configMinimumInteritemSpacing
{
    return 5.;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView ColumnCountOfSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.columncount > 0) {
        return cell_struce.columncount;
    }
    return 2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
        self.edgesForExtendedLayout = UIRectEdgeAll;//UIRectEdgeNone;
    }
     self.collectionView.backgroundColor = [UIColor clearColor];
     self.showBackItem = YES;
}
 

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#define UISCREEN_BOUNDS [UIScreen mainScreen].bounds

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGRect collectionViewFrame = CGRectMake(0,\
                                                0,\
                                                self.view.bounds.size.width,\
                                                self.view.bounds.size.height);
        
        HBCollectionFallFLayout *collectionViewFlowLayout = [[HBCollectionFallFLayout alloc] init];
        collectionViewFlowLayout.delegate = self;
        collectionViewFlowLayout.headerHeight = 0;
        collectionViewFlowLayout.minimumColumnSpacing = self.configMinimumColumnSpacing;
        collectionViewFlowLayout.minimumInteritemSpacing = self.configMinimumInteritemSpacing;
        collectionViewFlowLayout.sectionInset = self.configSectionInset;//UIEdgeInsetsMake(5, 5, 5, 5);
        collectionViewFlowLayout.columnCount = self.configColumnCount;
        self.collectionViewFlowLayout = collectionViewFlowLayout;
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:collectionViewFlowLayout];
//        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.allowsMultipleSelection = YES;
//        _collectionView.allowsSelection = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(64., 0, 0, 0);
        [_collectionView registerClass:[HBBaseSectionCollectionReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"HBBaseSectionCollectionReusableView"];
//        [_collectionView registerNib:[UINib nibWithNibName:@"HBBaseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HBBaseCollectionViewCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


-(void)viewDidCurrentView{

}

-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.collectionView.frame = CGRectMake(0, top, self.view.bounds.size.width ,self.view.bounds.size.height - top - bottom);
    return self.collectionView.frame;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.nodeselectRow) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    CELL_STRUCT * cellstruct = [self.dataDictionary  cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    if ( cellstruct.sel_selector && [self respondsToSelector:cellstruct.sel_selector])
    {
        [self performSelector:cellstruct.sel_selector withObject:cellstruct afterDelay:0];
    }
    else
    {
        NSString * sel_selector = cellstruct.sel_selector_str;
        SEL selector = NSSelectorFromString(sel_selector);
        if (sel_selector  && [self respondsToSelector:selector]) {
            [self performSelector:selector withObject:cellstruct afterDelay:0];
        }
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.dataDictionary.allKeys.count;
    NSArray * keys = self.dataDictionary.allKeys;
    NSString * sectionx = KEY_SECTION_MARK(section);
    NSInteger rowcount = 0;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        if ([key rangeOfString:sectionx].location != NSNotFound) {
            rowcount ++;
        }
    }
    return rowcount;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSInteger maxsection = 1;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        
        NSString * sectionstr = KEY_SECTION_INDEX_STR(key);
        if ((sectionstr.integerValue +1) > maxsection) {
            maxsection = (sectionstr.integerValue + 1);
        }
    }
    return maxsection;
}

-(NSString *)valiateCellClass:(NSString *)cellclass
{
    if ([cellclass isEqualToString:@"HBBaseTableViewCell"]) {
            return @"HBBaseCollectionViewCell";
    }
    return cellclass;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 =  [self valiateCellClass:cellstruct.cellclass];
    HBBaseCollectionViewCell *cell ;
    @try {
        cell =  [collectionView dequeueReusableCellWithReuseIdentifier:identifier01 forIndexPath:indexPath];
    }
    @catch (NSException *exception) {
        NSLog(@"😫--> 重用的cell %@找不到\n%@",identifier01,exception);
//        identifier01 = NSStringFromClass([HBBaseCollectionViewCell class]);
//        cell =  [[HBBaseCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];//[collectionView dequeueReusableCellWithReuseIdentifier:identifier01 forIndexPath:indexPath];
    }
    @finally {
    }
    if (!cell) {
        cell = [[HBBaseCollectionViewCell alloc] init];
    }
    if ([[cell class] isSubclassOfClass:[HBBaseCollectionViewCell class]]) {
        cell.delegate = self;
        cell.indexPath = indexPath;
//        [cell setcellimageRight:cellstruct.imageRight];
        [cell setcelldetailtitle:cellstruct.detailtitle];
        [cell setcellTitle:cellstruct.title];
        [cell setcellProfile:cellstruct.picture];
        [cell setcellpicturecolor:cellstruct.picturecolor];
        [cell setcellobject:cellstruct.object];
        [cell setcellobject2:cellstruct.object2];
        [cell setcellTitleColor:cellstruct.titlecolor];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellValue:cellstruct.value];
    }
    return cell;
}


-(CGFloat)itemWidth
{
    return  (self.view.bounds.size.width - 5 * (self.configColumnCount + 1)) / self.configColumnCount;;
}
#pragma mark - UICollectionViewDelegateFlowLayout
 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edgeinset = [self configInsetForSectionAtIndex:indexPath.section];
     CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSInteger realcolumcount = self.configColumnCount;
    if ([self respondsToSelector:@selector(collectionView:ColumnCountOfSection:)]) {
        realcolumcount = [self collectionView:collectionView ColumnCountOfSection:indexPath.section];
    }
    CGFloat cellSideLength = (self.view.bounds.size.width - edgeinset.left * (realcolumcount + 1)) / realcolumcount;
    CGFloat itemheight = (cellstruct.cellheight>0) ? cellstruct.cellheight:cellSideLength;
    CGSize cellSize = CGSizeMake(cellSideLength, itemheight);
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return [self configInsetForSectionAtIndex:section];//UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionheight;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        HBBaseSectionCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HBBaseSectionCollectionReusableView" forIndexPath:indexPath];
        CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, 0)];
        
        view.titleLabel.text = cell_struce.sectiontitle;
        CGFloat sectionfont = (cell_struce.sectionfont > 0)?cell_struce.sectionfont:12;
        view.titleLabel.font = [UIFont systemFontOfSize:sectionfont];
        view.titleLabel.textColor = [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectioncolor];
        view.titleLabel.textAlignment = NSTextAlignmentLeft;
        UIColor * bgcolor =  [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectionbgcolor];
        view.backgroundColor = bgcolor?bgcolor:self.view.backgroundColor;
        
        return view;
    }
    return nil;
}
-(NSString *)collectionView:(UICollectionView *)collectionView HeaderReuseIdentifierWithSection:(NSInteger)section
{
    return UICollectionElementKindSectionHeader;
}
 
@end
