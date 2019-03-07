//
//  CrowdFoundHeaderCell.m
//  PENG
//
//  Created by HUANGBO on 15/8/7.
//  Copyright (c) 2015年 YY.COM All rights reserved.
//

#import "CF_CrowdFoundHeaderCell.h"
@interface CF_CrowdFoundHeaderCell()
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_detail;
@property (weak, nonatomic) IBOutlet UISlider *slider_progress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_progress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_currentmoney;
@property (weak, nonatomic) IBOutlet UILabel *lbl_remaintime;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;
@property (weak, nonatomic) IBOutlet UIButton *btn_comment;
@property (weak, nonatomic) IBOutlet UILabel *lbl_state;
@property (weak, nonatomic) IBOutlet UIButton *btn_zan;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end
@implementation CF_CrowdFoundHeaderCell


+(CGFloat)heightOfCell
{
    return 252.;
}
-(void)setcellTitle:(NSString *)title{
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.slider_progress setThumbImage:[UIImage new] forState:UIControlStateNormal];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.bottomView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
