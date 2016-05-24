//
//  BaseViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "HBBaseViewController.h"
#import "UIButton+PENG.h"
#import "CELL_STRUCT_Common.h"

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
 
@implementation HBBaseViewController


-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary new];
    }
    return _dataDictionary;
}
/**
 *  从PLIST 文件中加载配置信息
 *
 *  @param plistname plist文件的名字
 */
-(void)loadplistConfig:(NSString *)plistname
{
    NSString * filepath = [[NSBundle mainBundle] pathForResource:plistname ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
    [self loadplistviewConfig:dic];
    for (NSString * key in dic.allKeys) {
        NSDictionary * adic = dic[key];
        if ([key containsString:@"section"] && adic) {
            CELL_STRUCT * cellstruct = [[CELL_STRUCT alloc] initWithPlistDictionary:adic];
            if (cellstruct) {
                [self.dataDictionary setObject:cellstruct forKey:key];
            }
        }
    }
}


/**
 *  从json文件中配置信息
 *
 *  @param jsonfilepath  json文件存放的路径名
 */
-(void)loadjsonfileConfig:(NSString *)jsonfilename
{
    NSString * filepath = [[NSBundle mainBundle] pathForResource:jsonfilename ofType:@"json"];
    NSError * error;
    NSString * jsonstring = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    if(error) { // If error object was instantiated, handle it.
        NSLog(@"ERROR while loading from file: %@", error);
        // …
    }
    else{
        CELL_STRUCT_ARRAY * vclist = [[CELL_STRUCT_ARRAY alloc] hb_initWithJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
        NSString * title = vclist.title;
        if (title && [[title class] isSubclassOfClass:[NSString class]]) {
            self.title = title;
        }
        NSString * backgroundcolor = vclist.backgroundcolor;
        if (backgroundcolor && [[backgroundcolor class] isSubclassOfClass:[NSString class]]) {
            self.view.backgroundColor = [CELL_STRUCT_Common colorWithStructKey:backgroundcolor];
        }
        NSString * backgroundimage  = vclist.backgroundimage;
        if (backgroundimage && [[backgroundimage class] isSubclassOfClass:[NSString class]]) {
            [self changeBackGroundWithBackImage:[UIImage imageNamed:backgroundimage]];
        }
        
        [vclist.array enumerateObjectsUsingBlock:^(CELL_STRUCT * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj && [obj.key_indexpath containsString:@"section"] ) {
                [self.dataDictionary setObject:obj forKey:obj.key_indexpath];
            }
        }];
    }
    
//    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
//    [self loadplistviewConfig:dic];
    
}

-(void)loadplistviewConfig:(NSDictionary *)dic
{
    NSString * title = [dic objectForKey:@"title"];
    if (title && [[title class] isSubclassOfClass:[NSString class]]) {
        self.title = title;
    }
    NSString * backgroundcolor = [dic objectForKey:@"backgroundcolor"];
    if (backgroundcolor && [[backgroundcolor class] isSubclassOfClass:[NSString class]]) {
       self.view.backgroundColor = [CELL_STRUCT_Common colorWithStructKey:backgroundcolor];
    }
    NSString * backgroundimage  = [dic objectForKey:@"backgroundimage"];
    if (backgroundimage && [[backgroundimage class] isSubclassOfClass:[NSString class]]) {
        [self changeBackGroundWithBackImage:[UIImage imageNamed:backgroundimage]];
    }
    
}


-(void)setShowBackItem:(BOOL)showBackItem
{
    _showBackItem = showBackItem;
    //TODO:设置返回按钮
    if (_showBackItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(backtoparent:)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
//    REMOVE_HBSIGNAL_OBSERVER(self, @"networkerror", @"HTTPSEngile")
}
-(void)viewDidLoad
{
    [super viewDidLoad]; //默认两行
    self.view.backgroundColor = [UIColor colorWithRed:239./255. green:239./255. blue:239./255. alpha:1];
}

-(IBAction)hbNavigationbartitleTap:(id)sender
{
    
}


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

-(void)changeFaceStyle:(int)style view:(UIView *)View
{
    
}

-(void)userDefaultBackground
{
    [self changeBackGroundWithBackColor:HB_UIColorWithRGB(14, 113, 196)];
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
    if (show) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(backtoparent:)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
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

-(BackGroundView *)backgroundview
{
    if (!_backgroundview) {
        BackGroundView * backgroundview =  [[BackGroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundview = backgroundview;
    }
    return _backgroundview;
}



@end
