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
#import "HBKitDataModel.h"

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


-(void)loadplistConfig:(NSString *)plistname filepath:(NSString *)filepath;
-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname filepath:(NSString *)filepath;
-(void)loadjsonfileConfig:(NSString *)jsonfilename filepath:(NSString *)filepath;

////是否需要用到MJRefresh
////上下拉要用到的
@property (nonatomic, assign) BOOL                       noFooterView;
@property (nonatomic, assign) BOOL                       noHeaderFreshView;
@end


@protocol HBBaseViewControllerDelegate

@optional
-(void)BaseViewController:(HBBaseViewController *)ViewController left:(BOOL)left navigationItem:(id)sender;


@end
