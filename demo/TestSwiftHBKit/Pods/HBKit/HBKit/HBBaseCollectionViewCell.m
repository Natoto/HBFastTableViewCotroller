//
//  BaseCollectionViewCell.m
//  PENG
//
//  Created by 星盛 on 15/10/20.
//  Copyright © 2015年 YY.COM All rights reserved.
//

#import "HBBaseCollectionViewCell.h"
#import "CELL_STRUCT_Common.h"
#import "CELL_STRUCT_KEY.h"
#import "UIButton+HBKit.h"
@interface HBBaseCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIButton *btn_title;

@end
@implementation HBBaseCollectionViewCell
-(void)setcelldictionary:(NSMutableDictionary *)dictionary{
    _dictionary = dictionary;
    UIColor * bgcolor = [dictionary objectForKey:key_cellstruct_background];
    if ([[bgcolor class] isSubclassOfClass:[UIColor class]]) {
        self.contentView.backgroundColor = bgcolor;
        self.backgroundColor = bgcolor;
    }
    if ([[bgcolor class] isSubclassOfClass:[NSString class]]) {
        NSString * bgcolorstring= [dictionary objectForKey:key_cellstruct_background];
        bgcolorstring = (bgcolorstring && bgcolorstring.length)?bgcolorstring:@"white";
        self.contentView.backgroundColor = [CELL_STRUCT colorWithStructKey:bgcolorstring];
        self.backgroundColor = self.contentView.backgroundColor;
    }
}

-(void)setcellTitleFontsize:(NSNumber *)titleFontsize
{
    if (titleFontsize.floatValue > 8) {
        self.btn_title.titleLabel.font = [UIFont systemFontOfSize:titleFontsize.floatValue];
    }
}

-(void)setcellTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        self.btn_title.titleLabel.font  = titleFont;
    }
}
-(void)setcellTitleColor:(NSString *)color
{
    UIColor * titlecolor = [CELL_STRUCT colorWithStructKey:color] ;
    if (titlecolor) {
        [self.btn_title setTitleColor:titlecolor];
    }
    else
    {
        [self.btn_title setTitleColor :[UIColor blackColor]];
    }
}

-(void)setcellProfile:(NSString *)profile{
    if (profile) {
        [self.btn_title setImage:[UIImage imageNamed:profile] forState:UIControlStateNormal];
    }
}

-(void)setcellTitle:(NSString *)title
{
    if (title) {
        [self.btn_title setTitle:title forState:UIControlStateNormal];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    if (_btn_title) {
//        [self.btn_title hbbase_setLayout:HBBaseImageTopTitleBootomStyle spacing:5];
//    }
}
//-(void)setcellimageRight:(BOOL)imageRight{}
-(void)setcellpicturecolor:(NSString *)picturecolor{}
-(void)setcellobject:(id)object{ self.object = object;};
-(void)setcellobject2:(id)object{}
-(void)setcelldelegate:(id)delegate{self.delegate = delegate;}
-(void)setcelldetailtitle:(NSString *)detail{}
-(void)setcellValue:(NSString *)value{}
@end
