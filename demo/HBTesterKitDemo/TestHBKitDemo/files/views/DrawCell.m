//
//  DrawCell.m
//  demo
//
//  Created by zeno on 16/2/2.
//  Copyright © 2016年 YY.COM All rights reserved.
//

#import "DrawCell.h"
@interface DrawCell()
@property(nonatomic,strong) NSString * title;
@end


@implementation DrawCell

-(BOOL)customizedStyle
{
    return YES;
}
-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    
}
-(void)setcellTitle:(NSString *)title
{
    if (![self.title isEqualToString:title]) {
        self.title = title;
//        [self setNeedsDisplay];
    }
}
 
-(void)setcellProfile:(NSString *)profile
{
    
}
-(void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.height - 20;
    CGFloat X = 0;
    CGFloat Y = 10;
    
    UIImage * image = [UIImage imageNamed:@"profile.png"];
    [image drawInRect:CGRectMake(10, 10, width, width)];
    X = 10 + width;
    Y = 20;
    
    
    if (self.title) {
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        [style setAlignment:NSTextAlignmentLeft];
        NSDictionary *attr = @{NSParagraphStyleAttributeName:style,
                               NSForegroundColorAttributeName:[UIColor orangeColor],
                               NSBackgroundColorAttributeName:[UIColor grayColor]};
        // [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
        [self.title drawInRect:CGRectMake(X, Y, rect.size.width - X - 20, 30) withAttributes:attr];
        Y = Y+30;
    }
    image = [UIImage imageNamed:@"beauty.png"];
    [image drawInRect:CGRectMake(X,Y, rect.size.width - X - 20, rect.size.height - Y)];
    
}

@end
