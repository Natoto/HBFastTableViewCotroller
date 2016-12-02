//
//  sectionCollectionReusableView.m
//  PENG
//
//  Created by 星盛 on 15/10/22.
//  Copyright © 2015年 YY.COM All rights reserved.
//

#import "HBBaseSectionCollectionReusableView.h"
#import "UIButton+HBKit.h"

@interface HBBaseSectionCollectionReusableView()
@end

@implementation HBBaseSectionCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel * label = [UILabel new];
        label.frame = CGRectMake(8, 0, self.bounds.size.width - 16, self.bounds.size.height);// self.bounds;
        label.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
