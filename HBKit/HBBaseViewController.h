//
//  BaseViewController.h
//  JXL
//
//  Created by 星盛 on 15/4/14.
//  Copyright (c) 2015年 BooB. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import "CELL_STRUCT.h"
#import "CELL_STRUCT_Common.h"

#undef KEY_INDEXPATH
#define KEY_INDEXPATH(SECTION,ROW) [NSString stringWithFormat:@"section%u_%u",(int)SECTION,(int)ROW]

#undef  KEY_SECTION
#define KEY_SECTION(SECTION) [NSString stringWithFormat:@"section%d",(int)SECTION]

#undef KEY_SECTION_MARK
#define KEY_SECTION_MARK(SECTION) [NSString stringWithFormat:@"section%d_",(int)SECTION]

#undef KEY_SECTION_INDEX_STR
#define KEY_SECTION_INDEX_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil)

//SECTION
#undef KEY_INDEXPATH_SECTION_STR
#define KEY_INDEXPATH_SECTION_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil)
//ROW
#undef  KEY_INDEXPATH_ROW_STR
#define KEY_INDEXPATH_ROW_STR(INDEXPATHKEY)  [INDEXPATHKEY substringFromIndex:(([INDEXPATHKEY rangeOfString:@"_"]).location + ([INDEXPATHKEY rangeOfString:@"_"]).length)]


#define ALPHA_NAVIGATIONBAR 0.7

@interface BackGroundView : UIView
@property(nonatomic,retain) UIImage * image;
@end

@protocol BaseViewControllerDelegate ;

@interface HBBaseViewController : UIViewController
{
    BOOL statusbarhidden;
} 
@property(nonatomic,strong) NSMutableDictionary * dataDictionary;

@property(nonatomic,assign) BOOL useStatusBar;//本界面配置statusbar 本界面消失后回归正常
@property(nonatomic,assign) BOOL showBackItem;
@property(nonatomic,assign) NSObject<BaseViewControllerDelegate> * basedelegate;

@property(nonatomic,strong) BackGroundView * backgroundview;

//@property(nonatomic,retain) HBNavigationbar * navigationbar;
//@property(nonatomic,retain) HBNavigationbar * navigationtoolsbar;

@property(nonatomic,assign) BOOL statusBarStyleDefault;
-(void)userDefaultBackground;

//改变背景颜色
-(void)changeBackGroundWithBackImage:(UIImage *)Image;
-(void)changeBackGroundWithBackimg:(NSString *)imgname ofType:(NSString *)type;
-(void)changeBackGroundWithBackimg:(NSString *)imgname;
-(void)changeFaceStyle:(int)style view:(UIView *)View;
-(void)changeBackGroundWithBackColor:(UIColor *)color;

/**
 * 设置navigationbar的状态
 */
//TODO:设置标题栏
//-(void)setnavigationWithBarBackgroundImage:(CGFloat)alpha;
//-(void)setnavigationWithBarBackgroundColor:(UIColor *)color;

//设置自定义navigationbar
-(void)showhbnavigationbarBackItem:(BOOL)show;
/**
 * 监听点击事件
 */
-(void)observeTapgestureWithSuperView:(UIView *)superview target:(id)target sel:(SEL)seletor;

-(IBAction)backtoparent:(id)sender;
-(IBAction)hbNavigationbartitleTap:(id)sender;


/**
 *  从PLIST 文件中加载配置信息
 *
 *  @param plistname plist文件的名字
 */
-(void)loadplistConfig:(NSString *)plistname;

/**
 *  从PLIST 文件中加载配置信息放到一个字典中而不是直接对datadictionary赋值
 *
 *  @param plistname plist文件的名字
 */
-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname;


/**
 *  从json文件中配置信息
 *
 *  @param jsonfilepath  json文件存放的路径名
 */
-(void)loadjsonfileConfig:(NSString *)jsonfilename;
@end


@protocol HBBaseViewControllerDelegate

@optional
-(void)BaseViewController:(HBBaseViewController *)ViewController left:(BOOL)left navigationItem:(id)sender;


@end