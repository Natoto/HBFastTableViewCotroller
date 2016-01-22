//
//  CommonView.h
//  JXL
//
//  Created by BooB on 15-5-1.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CELL_STRUCT.h"


#define AS_CELL_STRUCT_COMMON(OBJ) @property(nonatomic,retain) CELL_STRUCT * cell_struct_##OBJ;


//#define GET_CELL_STRUCT_ALLPARA_WITH(OBJ,TITLE,SELECTENABLE,ACCESSORY,HEIGHT,IMAGERIGHT,IMAGECORNER,TARGET,SELECTOR) -(CELL_STRUCT *)cell_struct_##OBJ\
//{\
//if (!_cell_struct_##OBJ) {\
//_cell_struct_##OBJ = [CELL_STRUCT cell_x_x_struct:@#TITLE detailvalue:nil footerheight:20 selectionStyle:SELECTENABLE  accessory:ACCESSORY cellheight:HEIGHT imageRight:IMAGERIGHT imageCornerRadius:IMAGECORNER target:TARGET selectAction:SELECTOR];\
//}\
//return _cell_struct_##OBJ;}

#define GET_CELL_STRUCT_WITH(OBJ,TITLE) -(CELL_STRUCT *)cell_struct_##OBJ\
{\
    if (!_cell_struct_##OBJ) {\
        _cell_struct_##OBJ = [CELL_STRUCT cell_x_x_struct:@#TITLE detailvalue:nil target:self selectAction:@selector(selectAction:)];\
    }\
    return _cell_struct_##OBJ;\
}


#define DEFAULT_CELL_SELECT_ACTION @selector(selectAction:)
#define GET_CELL_SELECT_ACTION(SENDER) -(IBAction)selectAction:(CELL_STRUCT *)SENDER

@interface CELL_STRUCT_Common : CELL_STRUCT
@end

@interface CELL_STRUCT(Common)


+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                         target:(id)target
                   selectAction:(SEL)selectAction;

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                     cellheight:(CGFloat)cellheight
                     imageRight:(BOOL)imageRight
              imageCornerRadius:(BOOL)imageCornerRadius
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
                     background:(UIColor *)backgroundcolor
                     titlecolor:(NSString *)titlecolor
                  sectionheight:(CGFloat)sectionheight;


+(CELL_STRUCT *)cell_x_x_structWithDictionary:(NSDictionary *)dictionary;

+(UIColor *)colorWithStructKey:(NSString *)key;

@end

@interface UIViewController(KEYINDEXPATH)
-(NSString *)KEY_INDEXPATH:(NSInteger )SECTION ROW:(NSInteger)ROW;
-(NSString *)KEY_SECTION:(NSInteger)SECTION;
-(NSString *)KEY_SECTION_MARK:(NSInteger)SECTION;
-(NSString *)KEY_SECTION_INDEX_STR:(NSString *)INDEXPATHKEY;
-(NSString *)KEY_INDEXPATH_SECTION_STR:(NSString *)INDEXPATHKEY;
-(NSString *)KEY_INDEXPATH_ROW_STR:(NSString *)INDEXPATHKEY; 
@end
