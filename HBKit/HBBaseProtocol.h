//
//  HBBaseProtocol.h
//  Pods
//
//  Created by boob on 16/11/29.
//
//

#ifndef HBBaseProtocol_h
#define HBBaseProtocol_h

@protocol HBBaseProtocol <NSObject>

-(void)setcelldictionary:(NSMutableDictionary *)dictionary;
-(void)setcellimageRight:(BOOL)imageRight;
-(void)setcellpicturecolor:(NSString *)picturecolor;
-(void)setcellobject:(id)object;
-(void)setcellobject2:(id)object;
-(void)setcelldelegate:(id)delegate;
-(void)setcellProfile:(NSString *)profile;
-(void)setcellTitle:(NSString *)title;
-(void)setcellTitleFont:(UIFont *)titleFont;
-(void)setcellAttributeTitle:(NSAttributedString *)attributeTitle;
-(void)setcellTitleColor:(NSString *)color;
-(void)setcellValue:(NSString *)value;
-(void)setcellValue2:(NSString *)value;
-(void)setcellRightValue:(NSString *)value;
-(void)setcellplaceholder:(NSString *)placeholder;
-(void)setcellArray:(NSMutableArray *)array;
-(void)setinputAccessoryView:(NSString *)inputAccessoryView;
-(void)setinputView:(NSString *)inputView;
-(void)setcelldetailtitle:(NSString *)detailtitle;
-(void)setcellimageCornerRadius:(BOOL)CornerRadius;
-(void)setcellTitleLabelNumberOfLines:(NSInteger)numberOfLines;
-(void)setcellTitleFontsize:(NSNumber *)titleFontsize;


//-(void)setcellAction:(SEL)action;
/**
 *  返回cell的高度 子类需要覆盖此方法
 *
 *  @return cell的size
 */
-(CGSize)sizeThatFits:(CGSize)size;
//protocol 自己定制化cell 不用里面的控件
-(BOOL)customizedStyle;
-(void)draw;
- (void)releaseMemory;;


@end
#endif /* HBBaseProtocol_h */
