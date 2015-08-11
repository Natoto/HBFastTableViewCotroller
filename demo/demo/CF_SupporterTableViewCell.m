//
//  CF_SupporterTableViewCell.m
//  PENG
//
//  Created by 跑酷 on 15/8/10.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import "CF_SupporterTableViewCell.h"

@implementation CF_SupporterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 55);
}
@end
