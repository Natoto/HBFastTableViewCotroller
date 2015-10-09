//
//  BaseTableViewCell.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "CELL_STRUCT_KEY.h"
#import "HB_BaseTableViewCell.h"
#import "CELL_STRUCT_Common.h"

@interface HB_BaseTableViewCell()

@end
@implementation HB_BaseTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.textColor = [UIColor grayColor]; 
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (void)awakeFromNib {
    
    NSString * string =(@"//////////////////////////////////////////////////////////////////////////////////////////");
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    string = (@"//////////////////////////////////////////////////////////////////////////////////////////");
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    string = (@"//////  //// /// //// ///   ////// ////// ///       ///// /      //////    ////////////////");
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"\\"];
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    
    string = (@"/////  //// /// //// /// // ///// / //// /// /////////// ////// ///// //// //////////////");
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"\\"];
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    string = (@"////       /// //// /// ///  /// // /// // /////   //// //    ////// //// ///////////////");
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"\\"];
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    
    string = (@"///  //// /// //// ///       // //// / /// ////// //// ////// ///// //// ////////////////");
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"\\"];
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    string = (@"//  //// ////   ///// ////// / ////// /////     ///// /      //////   /////////////////");
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"\\"];
    NSLog(@"%@",[string stringByReplacingOccurrencesOfString:@"/" withString:@" "]);
    
    HBLOG(@"//////////////////////////////////////////////////////////////////////////////////////////");
    HBLOG(@"//////////////////////////////////////////////////////////////////////////////////////////");
    HBLOG(@"//////////////////////////////////////////////////////////////////////////////////////////");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageRight) {//重新排版imageview
        CGFloat orix = self.imageView.frame.origin.x;
        CGFloat x = self.contentView.bounds.size.width - self.contentView.bounds.size.height;
        CGFloat y = 5;
        CGFloat width = self.contentView.bounds.size.height - 10;
        CGFloat height = width;
        self.imageView.frame = CGRectMake(x, y, width, height);
        
        x = orix;
        y = self.textLabel.frame.origin.y;
        width = self.textLabel.frame.size.width;
        height = self.textLabel.frame.size.height;
        self.textLabel.frame =  CGRectMake(x, y, width, height);
        
        x = self.detailTextLabel.frame.origin.x - self.imageView.bounds.size.height;
        y = self.detailTextLabel.frame.origin.y;
        width = self.detailTextLabel.frame.size.width;
        height = self.detailTextLabel.frame.size.height;
        self.detailTextLabel.frame = CGRectMake(x, y, width, height);
        self.separatorInset = UIEdgeInsetsMake(0, orix, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    }
    if (self.CornerRadius) {
        self.imageView .layer.masksToBounds = YES;\
        self.imageView .layer.borderColor =[UIColor whiteColor].CGColor;\
        self.imageView .layer.borderWidth = 0;
        CGFloat width = self.contentView.bounds.size.height - 10;
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, width, width);
        [self.imageView .layer setCornerRadius:width/ 2];
        self.imageView.center = CGPointMake(self.imageView.frame.origin.x + self.imageView.frame.size.width/2, self.contentView.bounds.size.height/2);
        self.textLabel.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + 5, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    }
    NSString *textAlignment = [self.dictionary objectForKey:key_cellstruct_textAlignment];
    if (textAlignment) {
        if ([textAlignment isEqualToString:value_cellstruct_textAlignment_left]) {
            self.textLabel.textAlignment = NSTextAlignmentLeft;
            self.textLabel.center = CGPointMake(self.textLabel.bounds.size.width/2 ,self.textLabel.center.y);
        }
        else if ([textAlignment isEqualToString:value_cellstruct_textAlignment_center]) {
            self.textLabel.center = CGPointMake(self.contentView.bounds.size.width/2,self.textLabel.center.y);
        }
        else if ([textAlignment isEqualToString:value_cellstruct_textAlignment_right]) {
            //            self.textLabel.textAlignment = NSTextAlignmentRight;
            self.textLabel.center = CGPointMake(self.contentView.bounds.size.width - self.textLabel.bounds.size.width/2 ,self.textLabel.center.y);
        }
    }

//   [self.textLabel setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width * 3 / 4, self.contentView.bounds.size.height / 2)];
}

-(void)setcellimageRight:(BOOL)imageRight
{
    self.imageRight = imageRight;
    if (imageRight) {
        [self layoutSubviews];
    }
}
//设置圆角
-(void)setcellimageCornerRadius:(BOOL)CornerRadius
{
    _CornerRadius = CornerRadius;
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (self.RoundCircleType) {
        if (_indexPath.row) {
            
        }
    }
}
-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    _dictionary = dictionary;
    UIColor * bgcolor = [dictionary objectForKey:key_cellstruct_background];
    if (bgcolor) {
        self.contentView.backgroundColor = bgcolor;
        self.backgroundColor = bgcolor;
    }
    NSString * detailvalue = [dictionary objectForKey:key_cellstruct_detailvalue];
    OBJ_NULL_DEFAULT(detailvalue, @"")
    NSNumber * imageCornerRadius = DIC_OBJ_KEY(dictionary, key_cellstruct_detailvalue);
    OBJ_NULL_DEFAULT(imageCornerRadius, @0)
    NSNumber * footerheight = DIC_OBJ_KEY(dictionary, key_cellstruct_sectionfooterheight);
    OBJ_NULL_DEFAULT(footerheight, @0)
    NSNumber * accessory = [dictionary objectForKey:key_cellstruct_accessory];
    OBJ_NULL_DEFAULT(accessory, @0)
    NSNumber * imageRight = [dictionary objectForKey:key_cellstruct_imageRight];
    OBJ_NULL_DEFAULT(imageRight, @0)
    UIColor * cellcolor = DIC_OBJ_KEY(dictionary, key_cellstruct_background);
    OBJ_NULL_DEFAULT(cellcolor, [UIColor whiteColor])
    NSString * titlecolor = [dictionary objectForKey:key_cellstruct_titlecolor];
    OBJ_NULL_DEFAULT(titlecolor, @"black")
    NSNumber * sectionheight = [dictionary objectForKey:key_cellstruct_sectionheight];
    OBJ_NULL_DEFAULT(sectionheight, @25)
//    [self setcellTitleColor:titlecolor];
};




//这个方法需要在子类写[super setcellobject];
-(void)setcellobject:(id)object
{   _object = object;    
 
} ;

-(void)setcellobject2:(id)object
{
    _object2 = object;
}

-(void)setcelldelegate:(id)delegate{}


-(void)setcellProfile:(NSString *)profile
{
    if ([profile hasPrefix:@"http://"] || [profile hasPrefix:@"https://"]) {//如果是网络图片 就加载网络图片
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:profile] placeholderImage:[UIImage imageFileNamed:@"big_icon"] options:SDWebImageLowPriority completed:nil];
        return;
    }
    if(profile.length)
    self.imageView.image = [UIImage imageNamed:profile];
}

-(void)setcellpicturecolor:(NSString *)picturecolor
{
    if (picturecolor) {
        if (self.imageView) {
            UIColor *  color = [CELL_STRUCT_Common colorWithStructKey:picturecolor];
            self.imageView.backgroundColor = color;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
}

-(void)setcellTitle:(NSString *)title
{
    self.textLabel.text = title;
}
-(void)setcellTitleColor:(NSString *)color
{
     UIColor * titlecolor = [CELL_STRUCT_Common colorWithStructKey:color] ;
    if (titlecolor) {
         self.textLabel.textColor = titlecolor;
    }
    else
    {
        self.textLabel.textColor = [UIColor blackColor];
    }
}
 -(void)setcelldetailtitle:(NSString *)detailtitle
{
    if (detailtitle) {
        self.detailTextLabel.text = detailtitle;        
    }
}
-(void)setcellRightValue:(NSString *)value{};
-(void)setcellValue:(NSString *)value{}
-(void)setcellValue2:(NSString *)value{}
-(void)setcellArray:(NSMutableArray *)array{}
-(void)setcellplaceholder:(NSString *)placeholder{}
-(void)setcellAction:(SEL)action{}
-(void)setinputAccessoryView:(NSString *)inputAccessoryView{}
-(void)setinputView:(NSString *)inputView{}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(size.width, 50);
}
@end
