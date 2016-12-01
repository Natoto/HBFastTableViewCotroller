

//       _      ______
//	/\ _\ \    /\  __ \
//	\   _  \   \ \  __<
//	 \ \  \ \   \ \_____\
//	  \/   \/    \/_____/
//
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 YY.COM All rights reserved.
//


#define PROTOCOL_OBJECT_DELEGATE(__OBJ,__MOTHOD) @protocol __OBJ##Delegate <NSObject>\
__MOTHOD\
@end

#define NO_DEFAULT_TITLE_PROFILE -(void)setcellProfile:(NSString *)profile{}
#define NO_DEFAULT_TITLE -(void)setcellTitle:(NSString *)title{}
#define NO_DEFAULT_PLACEHOLDER  -(void)setcelldetailtitle:(NSString *)detailtitle{}

#define HBLOG(SS) NSLog(@"%@",SS);

#import <UIKit/UIKit.h>
#import "CELL_STRUCT_KEY.h"
#import "HBBaseProtocol.h"

@interface HBBaseTableViewCell : UITableViewCell<HBBaseProtocol>
 
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
 
@end



@interface UIView(HBBASECELL)
@property(nonatomic,retain) UIView * toplayer;
@property(nonatomic,retain) UIView * bottomlayer;

-(void)clearTopLayer;
-(void)clearBottomLayer;
-(void)drawBottomlinelayer;
-(void)drawToplinelayer;
@end
