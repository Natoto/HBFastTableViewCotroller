//
//  HBBaseCollectionView.m
//  HBKit
//
//  Created by boob on 2017/9/22.
//

#import "HBBaseCollectionView.h"
#import "HBCellStruct.h"
#import "HBBaseCollectionViewCell.h"
#import "HBBaseSectionCollectionReusableView.h"
#import "HBCellStruct_Common.h"
#import "HBCellStruct_KEY.h"

@implementation HBBaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionView.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

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


#define UISCREEN_BOUNDS [UIScreen mainScreen].bounds

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGRect collectionViewFrame = CGRectMake(0,\
                                                0,\
                                                self.bounds.size.width,\
                                                self.bounds.size.height);
        _collectionView = [HBCProtocol createCollectionView:self frame:collectionViewFrame];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


-(void)viewDidCurrentView{
    
}

-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.collectionView.frame = CGRectMake(0, top, self.bounds.size.width ,self.bounds.size.height - top - bottom);
    return self.collectionView.frame;
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
        cell =  [collectionView dequeueReusableCellWithReuseIdentifier:identifier01 forIndexPath:indexPath];
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
    return  (self.bounds.size.width - 5 * (self.configColumnCount + 1)) / self.configColumnCount;;
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
    CGFloat cellSideLength = (self.bounds.size.width - edgeinset.left * (realcolumcount + 1)) / realcolumcount;
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
        UICollectionReusableView *view = [HBCProtocol collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath background:self.backgroundColor dataDictionary:self.dataDictionary];
        return view;
    }
    return nil;
}
-(NSString *)collectionView:(UICollectionView *)collectionView HeaderReuseIdentifierWithSection:(NSInteger)section
{
    return UICollectionElementKindSectionHeader;
}


@end
