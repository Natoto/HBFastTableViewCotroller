//
//  BaseTableViewCell.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 YY.COM All rights reserved.
//
#import "HBCellStruct_KEY.h"
#import "HBBaseTableViewCell.h"
#import "HBCellStruct_Common.h"
#import <objc/runtime.h>

@interface HBCirclePoint : UIView
@property(nonatomic,strong) UIColor * color;
@end

@interface HBRedPoint : HBCirclePoint
@end


@interface HBBaseTableViewCell()
@property(nonatomic,strong) HBRedPoint * redPoint;

@end
@implementation HBBaseTableViewCell
@synthesize indexPath = _indexPath;
@synthesize CornerRadius = _CornerRadius;
@synthesize dictionary = _dictionary;
@synthesize object = _object;
@synthesize object2 = _object2;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier plistdic:(NSDictionary *)plistdic{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { 
    }
    return self;
}

-(void)firstconfigcell:(NSDictionary *)dic{
    if (!self.customizedStyle) {
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _redPoint = [[HBRedPoint alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _redPoint.hidden = YES;
        [self.contentView addSubview:_redPoint];
    }
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self firstconfigcell:nil];
    }
    return self;
}

-(BOOL)customizedStyle
{
    return NO;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];

}
 
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.customizedStyle) {
        return;
    }
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
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            self.textLabel.center = CGPointMake(self.contentView.bounds.size.width/2,self.textLabel.center.y);
        }
        else if ([textAlignment isEqualToString:value_cellstruct_textAlignment_right]) {
            self.textLabel.textAlignment = NSTextAlignmentRight;
            self.textLabel.center = CGPointMake(self.contentView.bounds.size.width - self.textLabel.bounds.size.width/2 ,self.textLabel.center.y);
        }
    }
    
    if (self.showTopLine) {
        [self drawToplinelayer];
        NSString * toplayerinset = self.dictionary[key_cellstruct_toplayerinsets];
        if (toplayerinset) {
            UIEdgeInsets  insets  = UIEdgeInsetsFromString(toplayerinset);
            CGRect  layerframe = CGRectMake(insets.left, insets.top, [UIScreen mainScreen].bounds.size.width - insets.left - insets.right, 0.5);
           self.toplayer.frame = layerframe;
        }
        else{
            CGRect  layerframe = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
            self.toplayer.frame = layerframe;
        }
     }
    else
    {
        [self clearTopLayer];
    }
    
    if (self.showBottomLine) {
        [self drawBottomlinelayer];
        NSString * toplayerinset = self.dictionary[key_cellstruct_bottomlayerinsets];
        if (toplayerinset) {
            UIEdgeInsets  insets  = UIEdgeInsetsFromString(toplayerinset);
            CGRect  layerframe = CGRectMake(insets.left,  self.frame.size.height - insets.bottom - 0.5, [UIScreen mainScreen].bounds.size.width - insets.left - insets.right, 0.5);
            self.bottomlayer.frame = layerframe;
        }
        else
        {
            CGRect  layerframe = CGRectMake(0, self.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5);
            self.bottomlayer.frame = layerframe;
        }
        
    }else
    {
        [self clearBottomLayer];
    }
    self.redPoint.center = CGPointMake(self.contentView.frame.size.width - 20, self.contentView.frame.size.height/2);
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
    //[self layoutIfNeeded];
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
    NSString * titltfontname = dictionary[key_cellstruct_titleFontFamily];
    if (titltfontname.length && [[titltfontname class] isSubclassOfClass:[NSString class]]) {
        self.textLabel.font = [UIFont fontWithName:titltfontname size:self.textLabel.font.pointSize];
    }
    
    NSString * detailvalue = [dictionary objectForKey:key_cellstruct_detailvalue];
    OBJ_NULL_DEFAULT(detailvalue, @"")
    NSNumber * imageCornerRadius = DIC_OBJ_KEY(dictionary, key_cellstruct_detailvalue);
    OBJ_NULL_DEFAULT(imageCornerRadius, @0)
    
    NSNumber * newmsgcount = DIC_OBJ_KEY(dictionary, key_cellstruct_newmessagecount);
    OBJ_NULL_DEFAULT(newmsgcount, @0)
    self.showNewMsg = newmsgcount.boolValue;//是否显示红点
    self.redPoint.hidden = !self.showNewMsg;
    
};


-(void)setcellTitleFontsize:(NSNumber *)titleFontsize
{
    if (titleFontsize.floatValue > 8) {
        self.textLabel.font = [UIFont fontWithName:self.textLabel.font.fontName size:titleFontsize.floatValue];
    }
}

-(void)setcellTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        self.textLabel.font = titleFont;
    }
}
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
//        [self.imageView hb_setImageWithURL:[NSURL URLWithString:profile] placeholderImage:[UIImage imageFileNamed:@"big_icon"] options:0 completed:nil];
        return;
    }
    if (profile.length) {
        self.imageView.image = [UIImage imageNamed:profile];
    }
}

-(void)setcellpicturecolor:(NSString *)picturecolor
{
    if (picturecolor) {
        if (self.imageView) {
            UIColor *  color = [CELL_STRUCT colorWithStructKey:picturecolor];
            self.imageView.backgroundColor = color;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
}
-(void)setcellAttributeTitle:(NSAttributedString *)attributeTitle
{//被坑了  不起作用妈的
    //    if (attributeTitle) {
    //      self.textLabel.attributedText = attributeTitle;
    //    }
}
-(void)setcellTitle:(NSString *)title
{
    self.textLabel.text = title;
}
-(void)setcellTitleColor:(NSString *)color
{
    UIColor * titlecolor = [CELL_STRUCT colorWithStructKey:color] ;
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
-(void)setcellTitleLabelNumberOfLines:(NSInteger)numberOfLines
{
    self.numberOfLines = numberOfLines;
    self.textLabel.numberOfLines = numberOfLines;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
}
-(CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.textLabel sizeThatFits:size].height;
    totalHeight += [self.detailTextLabel sizeThatFits:size].height;
    return CGSizeMake(size.width, totalHeight);
}

-(void)setcellRightValue:(NSString *)value{};
-(void)setcellValue:(NSString *)value{}
-(void)setcellValue2:(NSString *)value{}
-(void)setcellArray:(NSMutableArray *)array{}
-(void)setcellplaceholder:(NSString *)placeholder{}
-(void)setcellAction:(SEL)action{}
-(void)setinputAccessoryView:(NSString *)inputAccessoryView{}
-(void)setinputView:(NSString *)inputView{}

-(void)draw{
}

- (void)clear{
}
- (void)releaseMemory{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self clear];
    [super removeFromSuperview];
}

@end


#pragma mark -  UIView(HBBASECELL)

@implementation UIView(HBBASECELL)
@dynamic toplayer;
@dynamic bottomlayer;

#define PENG_COLOR_LINE [UIColor colorWithRed:219./255. green:219./255. blue:219./255. alpha:1] 
//219 219 219
/**
 *  清除顶部分割线
 */
-(void)clearTopLayer
{
    UIView *imageLayer = self.toplayer;
    if (imageLayer) {
        imageLayer.hidden = YES;
    }
}

/**
 *  清除底部分割线
 */
-(void)clearBottomLayer
{
    UIView *imageLayer = self.bottomlayer;
    if (imageLayer) {
        imageLayer.hidden = YES;
    }
}

-(void)drawBottomlinelayer
{
    UIView *imageLayer = self.bottomlayer;
    CGRect layerframe =  CGRectMake(0, self.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5);
    if (!imageLayer) {
        imageLayer =  [self createLayer:layerframe color:self.top_bottom_line_color];
        [self addSubview:imageLayer];
        self.bottomlayer = imageLayer;
    }else
    {
        imageLayer.frame = layerframe;
    }
    [self bringSubviewToFront:imageLayer];
    imageLayer.hidden = NO;
}

-(UIColor *)top_bottom_line_color{
    return PENG_COLOR_LINE;
}

-(void)drawToplinelayer
{
    UIView *imageLayer = self.toplayer;
    CGRect  layerframe = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
    if (!imageLayer) {
        imageLayer =  [self createLayer:layerframe color:self.top_bottom_line_color];
        [self addSubview:imageLayer];
        self.toplayer = imageLayer;
    }else
    {
        imageLayer.frame = layerframe;
    }
    [self bringSubviewToFront:imageLayer];
    imageLayer.hidden = NO;
}

-(UIView *)createLayer:(CGRect)frame color:(UIColor *)color
{
    UIView *imageLayer = [UIView new];
    imageLayer.frame = frame; //CGRectMake(0, 0, UISCREEN_WIDTH, 0.5);
//    imageLayer.cornerRadius = 0;  //设置layer圆角半径
//    imageLayer.masksToBounds = YES;  //隐藏边界
    imageLayer.backgroundColor = color;//[UIColor colorWithWhite:0.6 alpha:0.8].CGColor;  //边框颜色
//    imageLayer.borderWidth = 0.5;
    return imageLayer;
}




static char  key_toplayer;
static char  key_bottomlayer;

-(UIView *)toplayer
{
    UIView * layer = (UIView *)objc_getAssociatedObject(self, &key_toplayer);
    return layer;
}

-(void)setToplayer:(UIView *)toplayer
{
    objc_setAssociatedObject(self, &key_toplayer, toplayer, OBJC_ASSOCIATION_RETAIN);
}
-(UIView *)bottomlayer
{
    UIView * layer = (UIView *)objc_getAssociatedObject(self, &key_bottomlayer);
    return layer;
}

-(void)setBottomlayer:(UIView *)bottomlayer
{
    objc_setAssociatedObject(self, &key_bottomlayer, bottomlayer, OBJC_ASSOCIATION_RETAIN);
}

@end



#pragma mark - REDPoint

@implementation HBRedPoint
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        self.color = [UIColor redColor];
        // Initialization code
    }
    return self;
}
@end

@implementation HBCirclePoint : UIView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawCircleWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2)
                        radius:rect.size.width/2];
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    //    [self setNeedsDisplay];
}

//圆形
-(void)drawCircleWithCenter:(CGPoint)center
                     radius:(float)radius
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddArc(pathRef,
                 &CGAffineTransformIdentity,
                 center.x,
                 center.y,
                 radius,
                 -M_PI/2,
                 radius*2*M_PI-M_PI/2,
                 NO);
    CGPathCloseSubpath(pathRef);
    
    CGContextAddPath(context, pathRef);
    UIColor * color = self.color?self.color:[UIColor redColor];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    //    CGContextDrawPath(context,kCGPathFillStroke); //画空心圆 并且去掉前面两行
    CGPathRelease(pathRef);
}

@end
