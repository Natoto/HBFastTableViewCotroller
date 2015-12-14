//
//  UIImage+Tint.h
//  DZ
//
//  Created by Nonato on 14-5-20.
//  Copyright (c) 2014年 pengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//改变图片的颜色
@interface  UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

/**
 *  @brief 图片着色
 *  @param blendMode: 着色方案
 *  @param alpha: 透明度
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

/**
 *  @brief 图片着色
 *  @param blendMode: 着色方案
 *  @param opaque: 是否透明
 *  @param scale: 缩放比例
 *  @param alpha: 透明度
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha opaque:(BOOL)opaque scale:(CGFloat)scale;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;
@end
