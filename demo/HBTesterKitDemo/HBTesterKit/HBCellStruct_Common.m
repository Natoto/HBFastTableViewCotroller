//
//  CommonView.m
//  JXL
//
//  Created by HUANGBO on 15-5-1.
//  Copyright (c) 2015年 YY.COM All rights reserved.
//

#import "HBCellStruct.h"
#import <HBTesterKit/HBTesterKit.h>
#import "HBCellStruct_Common.h"
#import "UIButton+HBKit.h" 
@implementation CELL_STRUCT_Common
@end

@implementation HBCellStruct(Common)

//最常用的
+(HBCellStruct *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                         target:(id)target
                   selectAction:(SEL)selectAction
{
    return  [HBCellStruct cell_x_x_struct:title
                             detailvalue:detailvalue
                            footerheight:0
                          selectionStyle:YES
                               accessory:YES
                              cellheight:44.
                              imageRight:NO
                       imageCornerRadius:NO
                                 picture:nil
                                  target:target
                            selectAction:selectAction
                              background:[UIColor whiteColor]
                              titlecolor:@"black" sectionheight:0];
}


+(HBCellStruct *)cell_x_x_struct:(NSString *)title
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
                  sectionheight:(CGFloat)sectionheight
{
    HBCellStruct * cell1_0 = [[HBCellStruct alloc] initWithtitle:title cellclass:NSStringFromClass([HBBaseTableViewCell class]) placeholder:@"" accessory:accessory sel_selctor:selectAction delegate:target];
    cell1_0.selectionStyle = selectionStyle;
    cell1_0.cellheight = cellheight;
    cell1_0.detailtitle = detailvalue?detailvalue:@"";
    cell1_0.sectionheight = footerheight;
    cell1_0.imageCornerRadius = imageCornerRadius;
    cell1_0.sectionfooterheight = footerheight;
    cell1_0.accessory = accessory;
    cell1_0.picture = picture;
//    cell1_0.imageRight = imageRight;
    cell1_0.titlecolor = titlecolor;
    cell1_0.sectionheight = sectionheight;
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:backgroundcolor}];
    return cell1_0;
}



//#define OBJECT_SETTER_FROM_DIC(OBJ,PARA,DIC) OBJ.m_##PARA=[NSString stringWithFormat:@"%@",[DIC objectForKey:[@#PARA stringByReplacingOccurrencesOfString:@"_" withString:@""]]];

+(HBCellStruct *)cell_x_x_structWithDictionary:(NSDictionary *)dictionary
{
    
    NSString * title = [dictionary objectForKey:key_cellstruct_title];
    id target = [dictionary objectForKey:key_cellstruct_delegate];
    SEL selectAction = NSSelectorFromString([dictionary objectForKey:key_cellstruct_selector]);
    NSNumber *selectionStyle = [dictionary objectForKey:key_cellstruct_selectionStyle];
    OBJ_NULL_DEFAULT(selectionStyle, @1)
    NSNumber * cellheight = [dictionary objectForKey:key_cellstruct_cellheight];
    OBJ_NULL_DEFAULT(cellheight, @40)
    NSString * detailvalue = [dictionary objectForKey:key_cellstruct_detailvalue];
    OBJ_NULL_DEFAULT(detailvalue, @"")
    NSNumber * imageCornerRadius = DIC_OBJ_KEY(dictionary, key_cellstruct_detailvalue);
    OBJ_NULL_DEFAULT(imageCornerRadius, @0)
    NSNumber * footerheight = DIC_OBJ_KEY(dictionary, key_cellstruct_sectionfooterheight);
    OBJ_NULL_DEFAULT(footerheight, @0)
    NSNumber * accessory = [dictionary objectForKey:key_cellstruct_accessory];
    OBJ_NULL_DEFAULT(accessory, @0)
    NSNumber * imageRight = [dictionary objectForKey:key_cellstruct_imageRight];
    OBJ_NULL_DEFAULT(imageRight, @0)
    UIColor * cellcolor = DIC_OBJ_KEY(dictionary, key_cellstruct_background);
    OBJ_NULL_DEFAULT(cellcolor, [UIColor whiteColor])
    NSString * titlecolor = [dictionary objectForKey:key_cellstruct_titlecolor];
    OBJ_NULL_DEFAULT(titlecolor, @"black")
    NSNumber * sectionheight = [dictionary objectForKey:key_cellstruct_sectionheight];
    OBJ_NULL_DEFAULT(sectionheight, @0)
    NSString * textAlignment = [dictionary objectForKey:key_cellstruct_textAlignment];
    
    HBCellStruct * cell1_0 = [[HBCellStruct alloc] initWithtitle:title cellclass:NSStringFromClass([HBBaseTableViewCell class]) placeholder:@"" accessory:NO sel_selctor:selectAction delegate:target];
    cell1_0.selectionStyle = selectionStyle.boolValue;
    cell1_0.cellheight = cellheight.floatValue;
    cell1_0.detailtitle = detailvalue;
    cell1_0.sectionheight = sectionheight.floatValue;
    cell1_0.imageCornerRadius = imageCornerRadius.boolValue;
    cell1_0.sectionfooterheight = footerheight.floatValue;
    cell1_0.accessory = accessory.boolValue;
//    cell1_0.imageRight = imageRight.boolValue;
    cell1_0.titlecolor = titlecolor;
    cell1_0.dictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [cell1_0.dictionary setObject:textAlignment forKey:key_cellstruct_textAlignment];
    return cell1_0;
}

/**
 *+ (UIColor *)blackColor;      // 0.0 white
 + (UIColor *)darkGrayColor;   // 0.333 white
 + (UIColor *)lightGrayColor;  // 0.667 white
 + (UIColor *)whiteColor;      // 1.0 white
 + (UIColor *)grayColor;       // 0.5 white
 + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
 + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
 + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
 + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
 + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
 + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
 + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
 + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
 + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
 + (UIColor *)clearColor;      // 0.0 white, 0.0 alpha
 */

//----------------------------------------------------------------- 颜色
#undef KT_HEXCOLORA
#define KT_HEXCOLORA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#undef KT_HEXCOLOR
#define KT_HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]


+(UIColor *)colorWithStructKey:(NSString *)key
{ 
    if (!key) return nil;
    if ([key rangeOfString:@"0x"].location!= NSNotFound || [key rangeOfString:@"0X"].location!= NSNotFound) {
        //先以16为参数告诉strtoul字符串参数表示16进制数字，然后使用0x%X转为数字类型
        unsigned long red = strtoul([key UTF8String],0,16);
        //NSLog(@"转换完的数字为：%lx",red);
        UIColor * color = KT_HEXCOLOR(red);
        return color;
    }
    
    if ([key isEqualToString:@"random"]) {
        return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    }
    
    if ([key isEqualToString:value_cellstruct_blue]) {
        return  CELL_STRUCT_COLOR(blue);
    }
    if ([key isEqualToString:@"darkGray"]) {
        return  CELL_STRUCT_COLOR(darkGray);
    }
    if ([key isEqualToString:@"lightGray"]) {
        return  CELL_STRUCT_COLOR(lightGray);
    }
    else if([key isEqualToString:value_cellstruct_white])
    {
        return CELL_STRUCT_COLOR(white);
    }
    else if([key isEqualToString:value_cellstruct_gray])
    {
        return CELL_STRUCT_COLOR(gray);
    }
    else if([key isEqualToString:value_cellstruct_red])
    {
        return CELL_STRUCT_COLOR(red);
    }
    else if([key isEqualToString:value_cellstruct_green])
    {
        return CELL_STRUCT_COLOR(green);
    }
    else if([key isEqualToString:value_cellstruct_blue])
    {
        return CELL_STRUCT_COLOR(blue);
    }
    else if([key isEqualToString:value_cellstruct_cyan])
    {
        return CELL_STRUCT_COLOR(cyan);
    }
    else if([key isEqualToString:value_cellstruct_yellow])
    {
        return CELL_STRUCT_COLOR(yellow);
    }
    else if([key isEqualToString:value_cellstruct_magenta])
    {
        return CELL_STRUCT_COLOR(magenta);
    }
    else if([key isEqualToString:value_cellstruct_orange])
    {
        return CELL_STRUCT_COLOR(orange);
    }
    else if([key isEqualToString:value_cellstruct_purple])
    {
        return CELL_STRUCT_COLOR(purple);
    }
    else if([key isEqualToString:value_cellstruct_brown])
    {
        return CELL_STRUCT_COLOR(brown);
    }
    else if([key isEqualToString:value_cellstruct_clear])
    {
        return CELL_STRUCT_COLOR(clear);
    }
    
    return nil;
}

@end

@implementation NSDictionary(cellstruct)

-(HBCellStruct *)cellstructobjectForKey:(id)aKey
{
    HBCellStruct * cellstruct = [self objectForKey:aKey];
    if (!cellstruct) {
        cellstruct = [[HBCellStruct alloc] init];
        [self setValue:cellstruct forKey:aKey];
    }
    return cellstruct;
}
@end


@implementation NSObject(KEYINDEXPATH)
-(NSString *)key_indexpath:(NSInteger )section row:(NSInteger)row
{
  return KEY_INDEXPATH(section,row);
}

-(NSString *)key_section:(NSInteger)section
{
    return KEY_SECTION(section);
}
//#define KEY_SECTION(SECTION) [NSString stringWithFormat:@"section%d",(int)SECTION]
//#define KEY_SECTION_MARK(SECTION) [NSString stringWithFormat:@"section%d_",(int)SECTION]
-(NSString *)key_section_mark:(NSInteger)section
{
    return  [NSString stringWithFormat:@"section%d_",(int)section];
}

-(NSString *)key_section_index_str:(NSString *)indexpathkey
{
    return  ((indexpathkey.length >9)?[indexpathkey substringWithRange:NSMakeRange(7, 1)]:nil);
}
//#define KEY_SECTION_INDEX_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil)

//SECTION
//#define KEY_INDEXPATH_SECTION_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil)

-(NSString *)key_indexpath_section_str:(NSString *)indexpathkey
{
    return  ((indexpathkey.length >9)?[indexpathkey substringWithRange:NSMakeRange(7, 1)]:nil);
}

//ROW
//#define KEY_INDEXPATH_ROW_STR(INDEXPATHKEY)  [INDEXPATHKEY substringFromIndex:(([INDEXPATHKEY rangeOfString:@"_"]).location + ([INDEXPATHKEY rangeOfString:@"_"]).length)]
-(NSString *)key_indexpath_row_str:(NSString *)indexpathkey
{
    return  [indexpathkey substringFromIndex:(([indexpathkey rangeOfString:@"_"]).location + ([indexpathkey rangeOfString:@"_"]).length)];
}
 
@end
