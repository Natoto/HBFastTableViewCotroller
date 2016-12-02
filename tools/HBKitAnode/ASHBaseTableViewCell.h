//
//  ASHBaseTableViewCell.h
//  HBCircleWidthDemo
//
//  Created by boob on 16/11/30.
//  Copyright © 2016年 YY.COM. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <HBKit/HBKit.h>

@interface ASHBaseTableViewCell : ASCellNode<HBBaseProtocol>

@property (nonatomic,assign ) BOOL showNewMsg;
@property (nonatomic,assign ) BOOL showTopLine;
@property (nonatomic,assign ) BOOL showBottomLine;
@property (nonatomic,assign ) BOOL canAnimate;
@property (nonatomic,assign ) BOOL RoundCircleType;
@property (nonatomic,assign ) BOOL imageRight;
@property (nonatomic,assign ) BOOL CornerRadius;
@property (nonatomic,assign ) SEL  selector;
@property (nonatomic,weak   ) id   delegate;
@property (nonatomic,strong ) id   object;
@property (nonatomic,strong ) id   object2;
@property (nonatomic,assign) NSInteger           numberOfLines;
@property (nonatomic,strong) NSIndexPath         * indexPath;
@property (nonatomic,strong) NSString            * subvalue2;
@property (nonatomic,strong) NSMutableDictionary * dictionary;

@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;


//- (instancetype)initWithDataInfo:(cell_struct *)datainfo;
@end
