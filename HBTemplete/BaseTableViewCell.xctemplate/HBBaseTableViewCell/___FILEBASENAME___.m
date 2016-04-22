//
//       _      ______
//	/\ _\ \    /\  __ \
//	\   _  \   \ \  __<
//	 \ \  \ \   \ \_____\
//	  \/   \/    \/_____/
//
//
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAME___ ()
#pragma mark- as

#pragma mark- model

@end

@implementation ___FILEBASENAME___
/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //使用类名alloc时，在此添加初始化配置
    }
    return self;
}
 */

- (void)awakeFromNib {
    //使用xib时在此添加初始化配置
}

-(void)setcellTitle:(NSString *)title
{
    
}

-(void)setcellProfile:(NSString *)profile
{
//    [super setcellProfile:profile];
}

-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    [super setcelldictionary:dictionary];
}
 
- (void)layoutSubviews
{
    [super layoutSubviews];
    //如果需要在此添加
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



#pragma mark - private
/*
 -(IBAction)buttonTap:(UIButton *)sender
 {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hbtableViewCell:subView:TapWithTag:)]) {
        [self.delegate hbtableViewCell:self subView:sender TapWithTag:sender.tag];
    }
 }
 */
#pragma mark - getter / setter
#pragma mark -


/*
+(CGFloat)heightOfCell
{
    return 44.0
}*/


@end
