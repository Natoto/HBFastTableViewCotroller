//
//  CELL_STRUCT.h
//  JXL
//
//  Created by BooB on 15-4-15.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CELL_STRUCT_KEY.h"


#define KEY_INDEXPATH(SECTION,ROW) [NSString stringWithFormat:@"section%u_%u",(int)SECTION,(int)ROW]
#define KEY_SECTION(SECTION) [NSString stringWithFormat:@"section%d",(int)SECTION]
@interface CELL_STRUCT : NSObject

@property(nonatomic,assign) CGFloat     cellheight;
@property(nonatomic,assign) SEL         sel_selector;
@property(nonatomic,retain) NSString  * key_indexpath;
@property(nonatomic,retain) NSString  * cellclass;
@property(nonatomic,retain) NSString  * sectiontitle;
@property(nonatomic,assign) CGFloat     sectionfont;
@property(nonatomic,retain) NSString  * sectionfooter;
@property(nonatomic,retain) NSString  * sectioncolor;
@property(nonatomic,assign) CGFloat     sectionheight;
@property(nonatomic,assign) CGFloat     sectionfooterheight;
@property(nonatomic,retain) NSString  * title;

//@property(nonatomic,retain) NSString  * textAlignment;

@property(nonatomic,retain) NSString  * detailtitle;
@property(nonatomic,retain) NSString  * value;
@property(nonatomic,retain) NSString  * tempvalue;
@property(nonatomic,retain) NSString  * xibvalue;
@property(nonatomic,retain) NSString  * subvalue2;
@property(nonatomic,retain) NSString  * placeHolder;
@property(nonatomic,retain) NSString  * titlecolor;
@property(nonatomic,retain) NSString  * cellctr;
@property(nonatomic,retain) NSString  * picture;
@property(nonatomic,retain) NSString  * picturecolor;
@property(nonatomic,retain) NSString  * rightComponts;
@property(nonatomic,retain) NSString  * rightValue;
@property(nonatomic,assign) BOOL        accessory;
@property(nonatomic,assign) BOOL        selectionStyle;
@property(nonatomic,assign) BOOL        imageRight;
@property(nonatomic,assign) BOOL        imageCornerRadius;
@property(nonatomic,assign) int         CellStyleValue;//修改cell默认的样式 0 1 2
@property(nonatomic,retain) NSMutableArray * array;
@property(nonatomic,retain) NSMutableArray * uploadobjcts;
@property(nonatomic,retain) NSMutableDictionary *dictionary;
@property(nonatomic,assign) NSInteger       uploadingIndex;
@property(nonatomic,assign) id              delegate;
@property(nonatomic,retain) id              object;
@property(nonatomic,retain) id              object2;
@property(nonatomic,assign) id          sectionHeaderView;
@property(nonatomic,retain) NSString    * inputAccessoryView;
@property(nonatomic,retain) NSString    * inputView;

-(id)initWithtitle:(NSString *)title cellclass:(NSString *)cellclass placeholder:(NSString *)placehoder accessory:(BOOL)accessory sel_selctor:(SEL)selector delegate:(id)delegate;


-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
