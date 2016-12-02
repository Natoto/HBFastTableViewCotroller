//
//  ASHBaseTableViewCell.m
//  HBCircleWidthDemo
//
//  Created by boob on 16/11/30.
//  Copyright © 2016年 YY.COM. All rights reserved.
//
#import "ASHBaseTableViewCell.h"
 
//颜色 两种参数
#define RGB_255(r,g,b) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1]

@interface ASHBaseTableViewCell()

@property (nonatomic, strong)  UIFont * titleFont;
@property (nonatomic, strong)  UIFont * detailFont;
@property (nonatomic, strong)  UIColor * titleColor;
@property (nonatomic, strong)  UIColor * detailColor;

@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASTextNode *detailNode;
@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASDisplayNode *topLineNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
@property (nonatomic, strong) CELL_STRUCT * dataInfo;
@end

@implementation ASHBaseTableViewCell

@synthesize indexPath = _indexPath;
@synthesize CornerRadius = _CornerRadius;
@synthesize dictionary = _dictionary;
@synthesize object = _object;
@synthesize object2 = _object2;

- (instancetype)init
{
    if (self = [super init]) {
//        self.dataInfo = datainfo;
        [self addTitleNode];
        
        [self addDetailNode];
        
        [self addImageNode];
        
        [self addTopLineNode];
        
        [self addUnderLineNode];
        
    }
    return self;
}

- (void)didLoad
{
    [super didLoad];
    
}


- (void)addTitleNode
{
    ASTextNode *titleNode = [[ASTextNode alloc]init];
    titleNode.placeholderEnabled = YES;
    titleNode.placeholderColor = self.titleColor;
    titleNode.layerBacked = YES;
    titleNode.maximumNumberOfLines = 0;
    [self addSubnode:titleNode];
    _titleNode = titleNode;
}

- (void)addDetailNode
{
    ASTextNode *titleNode = [[ASTextNode alloc]init];
    titleNode.placeholderEnabled = YES;
    titleNode.placeholderColor = self.detailColor;
    titleNode.layerBacked = YES;
    titleNode.maximumNumberOfLines = 0;
    
    [self addSubnode:titleNode];
    _detailNode = titleNode;
}
- (void)addImageNode
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc]init];
    imageNode.layerBacked = YES;
    [self addSubnode:imageNode];
    _imageNode = imageNode;
}

- (void)addTopLineNode
{
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc]init];
    underLineNode.layerBacked = YES;
    underLineNode.backgroundColor = RGB_255(223, 223, 223);
    [self addSubnode:underLineNode];
    _topLineNode = underLineNode;
}

- (void)addUnderLineNode
{
    ASDisplayNode *underLineNode = [[ASDisplayNode alloc]init];
    underLineNode.layerBacked = YES;
    underLineNode.backgroundColor = RGB_255(223, 223, 223);
    [self addSubnode:underLineNode];
    _underLineNode = underLineNode;
}



- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    @synchronized (self) {
        if (_imageNode.URL) {
            _imageNode.preferredFrameSize = CGSizeMake(50, 50);
            _imageNode.alignSelf = ASStackLayoutAlignSelfStart;
        }
        _titleNode.flexShrink = YES;
        _underLineNode.preferredFrameSize = CGSizeMake(constrainedSize.max.width, 0.5);
        _topLineNode.preferredFrameSize = CGSizeMake(constrainedSize.max.width, 0.5);
        NSArray * verchidren = @[_titleNode,_detailNode];
        if (!_detailNode.attributedText) {
            verchidren = @[_titleNode,_detailNode];
        }
        ASStackLayoutSpec *verContentStackLayout = [ASStackLayoutSpec
                                                    stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                    spacing:5
                                                    justifyContent:ASStackLayoutJustifyContentCenter
                                                    alignItems:ASStackLayoutAlignItemsStart
                                                    children:@[_titleNode,_detailNode]];
        verContentStackLayout.flexShrink = YES;
        
        ASStackLayoutSpec *horStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_imageNode,verContentStackLayout]];
        
        ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:horStackLayout];
        
        NSArray * lastchilren = @[insetLayout];
        if (self.showTopLine) {
            lastchilren = @[_topLineNode,insetLayout];
        }
        if (self.showBottomLine) {
            lastchilren = @[insetLayout,_underLineNode];
        }
        if (self.showTopLine && self.showBottomLine) {
            lastchilren = @[_topLineNode,insetLayout,_underLineNode];
        }
        ASStackLayoutSpec *verStackLayout = ([ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:lastchilren]);
        
        NSLog(@"~~~~ count: %ld",lastchilren.count);
        if (lastchilren.count > 1) {
            return  verStackLayout;
        }
        else{
            return insetLayout;
        }
    }
   

}

- (void)layout
{
    [super layout];
    //    _imageView.frame = _imageNode.frame;
}

-(void)setcellobject:(id)object{
    self.object = object;
}
-(void)setcelldelegate:(id)delegate{
    self.delegate = delegate;
}
-(void)setcellProfile:(NSString *)profile{
    
    if (!profile || !profile.length) {
        self.imageNode.URL = nil;
        return;
    }
    if ([profile hasPrefix:@"http://"] || [profile hasPrefix:@"https://"]) {
        //如果是网络图片 就加载网络图片
        _imageNode.URL = [NSURL URLWithString:profile];
        return;
    }
    _imageNode.image = [UIImage imageNamed:profile];;

}

-(void)setcellTitle:(NSString *)title{

    NSDictionary *attrs = @{ NSFontAttributeName: self.titleFont ,NSForegroundColorAttributeName:self.titleColor};
    self.titleNode.attributedText = [[NSAttributedString alloc]initWithString:title attributes:attrs];
}
-(void)setcelldetailtitle:(NSString *)detailtitle{
    NSDictionary *attrs = @{ NSFontAttributeName:self.detailFont ,NSForegroundColorAttributeName:self.detailColor};
    self.detailNode.attributedText = [[NSAttributedString alloc]initWithString:detailtitle attributes:attrs];
}

-(void)setcelldictionary:(NSMutableDictionary *)dictionary{
    _dictionary = dictionary;
    UIColor * bgcolor = [dictionary objectForKey:key_cellstruct_background];
    if ([[bgcolor class] isSubclassOfClass:[UIColor class]]) {
        self.backgroundColor = bgcolor;
    }
    if ([[bgcolor class] isSubclassOfClass:[NSString class]]) {
        NSString * bgcolorstring= [dictionary objectForKey:key_cellstruct_background];
        bgcolorstring = (bgcolorstring && bgcolorstring.length)?bgcolorstring:@"white";
        self.backgroundColor = [CELL_STRUCT colorWithStructKey:bgcolorstring];
    }
}



-(void)setcellimageRight:(BOOL)imageRight{}
-(void)setcellpicturecolor:(NSString *)picturecolor{}
-(void)setcellobject2:(id)object{}

-(void)setcellTitleFont:(UIFont *)titleFont{
    if (titleFont) {
        self.titleFont = titleFont;
    }
    else{
        self.titleFont = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    }
}

-(void)setcellAttributeTitle:(NSAttributedString *)attributeTitle{
    if (attributeTitle && [[attributeTitle class] isSubclassOfClass:[NSAttributedString class]]) {
        self.titleNode.attributedString = attributeTitle;
    }
}
-(void)setcellTitleColor:(NSString *)color{
    if (color) {
        UIColor * clr = [CELL_STRUCT colorWithStructKey:color];
        self.titleColor = clr;
    }
    else{
        self.titleColor =  RGB_255(33, 33, 33);;
    }
}
-(void)setcellTitleFontsize:(NSNumber *)titleFontsize{
    if (titleFontsize) {
        _titleFont =  [UIFont fontWithName:self.titleFont.fontName size:titleFontsize.floatValue];
    }
    else{
        _titleFont =  [UIFont fontWithName:self.titleFont.fontName size:15.0f];
    }
}
-(CGSize)sizeThatFits:(CGSize)size{ return self.bounds.size;}
-(BOOL)customizedStyle{return NO;}
-(void)draw{}
- (void)releaseMemory{}

#pragma mark - getter setter

-(UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont =  [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    }
    return _titleFont;
}
-(UIFont *)detailFont{
    if (!_detailFont) {
        _detailFont =  [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    }
    return _detailFont;
}
-(UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = RGB_255(33, 33, 33);
    }
    return _titleColor;
}
-(UIColor *)detailColor{
    if (!_detailColor) {
        _detailColor =  RGB_255(150, 150, 150);
    }
    return _detailColor;
}


-(void)setcellValue:(NSString *)value{}
-(void)setcellValue2:(NSString *)value{}
-(void)setcellRightValue:(NSString *)value{}
-(void)setcellplaceholder:(NSString *)placeholder{}
-(void)setcellArray:(NSMutableArray *)array{}
-(void)setinputAccessoryView:(NSString *)inputAccessoryView{}
-(void)setinputView:(NSString *)inputView{}
-(void)setcellimageCornerRadius:(BOOL)CornerRadius{}
-(void)setcellTitleLabelNumberOfLines:(NSInteger)numberOfLines{
    
}

@end
