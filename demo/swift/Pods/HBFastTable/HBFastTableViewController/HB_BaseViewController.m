//
//  BaseViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "HB_BaseViewController.h"
#import "UIButton+PENG.h"

#define HB_UIColorWithRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@implementation BackGroundView
-(void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self.image drawInRect:CGRectMake(0, -10, rect.size.width, rect.size.height + 10)];
    // Drawing code
}
@end



@implementation HB_BaseViewController


-(void)setShowBackItem:(BOOL)showBackItem
{
    _showBackItem = showBackItem;
    //TODO:设置返回按钮
//    if (_showBackItem) {
//        [self.navigationbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"white_back_btn"] target:self selector:@selector(backtoparent:)];
//    }
//    else
//    {
//        self.navigationbar.leftItem = nil;
//    }
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
//    REMOVE_HBSIGNAL_OBSERVER(self, @"networkerror", @"HTTPSEngile")
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
//    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = HB_UIColorWithRGB(245, 245, 245);// [UIColor grayColor];
    self.navigationItem.backBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@""
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil
                                                                          action:nil];
    
//    ADD_HBSIGNAL_OBSERVER(self, @"networkerror", @"HTTPSEngine");
}
-(void)setTitle:(NSString *)title
{
    //设置标题栏
//    UIButton * button = [UIButton CreateButtonWithFrame:CGRectMake(80, 5, 220, 44) andTxt:title];
//    //    [self.navigationbar setTitle:title];
//    [button addTarget:self action:@selector(hbNavigationbartitleTap:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationbar.titleView = button;
}

-(IBAction)hbNavigationbartitleTap:(id)sender
{
    
}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//     if (self.statusBarStyleDefault) {
//         return UIStatusBarStyleDefault;
//     }
//    else
//        return UIStatusBarStyleLightContent;
//}
//
//-(void)setStatusBarStyleDefault:(BOOL)statusBarStyleDefault
//{
//    _statusBarStyleDefault = statusBarStyleDefault; 
//}

//static UIStatusBarStyle barstyle;

-(void)setStatusBarStyleDefault:(BOOL)statusBarStyleDefault
{
    _statusBarStyleDefault = statusBarStyleDefault;
    if (self.statusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.useStatusBar) {
        statusbarhidden = [UIApplication sharedApplication].statusBarHidden;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.useStatusBar) {
        if (statusbarhidden != [UIApplication sharedApplication].statusBarHidden) {
            [[UIApplication sharedApplication] setStatusBarHidden:statusbarhidden];
        }
    }
}
//TODO: 网络错误
//ON_HBSIGNAL(HTTPSEngine, networkerror, notify)
//{
//    [self dismissAllTips];
//}

-(void)changeFaceStyle:(int)style view:(UIView *)View
{
    
}

-(void)userDefaultBackground
{
    [self changeBackGroundWithBackColor:HB_UIColorWithRGB(14, 113, 196)];
//    [self changeBackGroundWithBackimg:@"backgroundimage@2x" ofType:@"png"];
}

-(void)changeBackGroundWithBackImage:(UIImage *)Image
{
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];//
    if (!imageview) {
        imageview = [[UIImageView alloc] initWithImage:Image];
        imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
        [self.view addSubview:imageview];
        imageview.tag = 2222;
        [self.view sendSubviewToBack:imageview];
    }
    imageview.image = Image;
}

-(void)changeBackGroundWithBackColor:(UIColor *)color
{
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];
    if (!imageview) {
        imageview = [[UIImageView alloc] init];
        imageview.tag = 2222;
        [self.view addSubview:imageview];
    }
    imageview.backgroundColor = color;
    imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    [self.view sendSubviewToBack:imageview];
}

-(void)changeBackGroundWithBackimg:(NSString *)imgname ofType:(NSString *)type
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imgname ofType:type]; 
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];
    if (!imageview) {
        imageview = [[UIImageView alloc] initWithImage:img];
        imageview.tag = 2222;
        [self.view addSubview:imageview];
    }
    imageview.image = img;
    imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    [self.view sendSubviewToBack:imageview];
}
-(void)changeBackGroundWithBackimg:(NSString *)imgname
{
    [self changeBackGroundWithBackimg:imgname ofType:@"png"];
}


-(void)showhbnavigationbarBackItem:(BOOL)show
{
//TODO:设置返回键
//    [self.navigationbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"white_back_btn"] target:self selector:@selector(backtoparent:)];
}

-(IBAction)backtoparent:(id)sender
{
    if (self.navigationController.childViewControllers.count >1 && self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark 点击手势
-(void)observeTapgestureWithSuperView:(UIView *)superview target:(id)target sel:(SEL)seletor
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:seletor];
    [superview addGestureRecognizer:tap];
}


/**
 * 设置navigationbar的状态
 */

//-(void)setnavigationWithBarBackgroundImage:(CGFloat)alpha
//{
//    if (alpha) {
//        UIImage * bgimage = [UIImage imageNamed:@"navigationbar.jpg"];
//        bgimage = [bgimage imageWithTintColor:[UIColor colorWithWhite:0 alpha:alpha]];
//        [self.navigationController.navigationBar setBackgroundImage:bgimage
//                                                      forBarMetrics:UIBarMetricsDefault];
//    }
//    else
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                      forBarMetrics:UIBarMetricsDefault];
//    }
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//}
//
//-(void)setnavigationWithBarBackgroundColor:(UIColor *)color
//{
//    if (color) {
//        UIImage * bgimage = [UIImage imageNamed:@"navigationbar.jpg"];
//        bgimage = [bgimage imageWithTintColor:color]; 
//        [self.navigationController.navigationBar setBackgroundImage:bgimage
//                                                      forBarMetrics:UIBarMetricsDefault];
//    }
//    else
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                      forBarMetrics:UIBarMetricsDefault];
//    }
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//}
//
//
//-(HBNavigationbar *)navigationtoolsbar
//{
//    if (!_navigationtoolsbar) {
//        _navigationtoolsbar = [HBNavigationbar navigationtoolbar];
//        [self.view addSubview:_navigationtoolsbar];
//    }
//    return _navigationtoolsbar;
//}
//
//-(HBNavigationbar *)navigationbar
//{
//    if (!_navigationbar) {
//       _navigationbar = [HBNavigationbar navigationbar];
//        _navigationbar.backgroundColor = KT_HEXCOLOR(0xffb612);
//        [self.view addSubview:_navigationbar];
//    }
//    return _navigationbar;
//}


-(BackGroundView *)backgroundview
{
    if (!_backgroundview) {
        BackGroundView * backgroundview =  [[BackGroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundview = backgroundview;
    }
    return _backgroundview;
}



@end
