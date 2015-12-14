//
//  UIView+Transition.h
//  pengmi
//
//  Created by 星盛 on 15/3/26.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BeeUITransitionDirectionRight,
    BeeUITransitionDirectionLeft,
    BeeUITransitionDirectionTop,
    BeeUITransitionDirectionBottom
} BeeUITransitionDirection;

typedef enum
{
    BeeUITransitionTypeDefault,
    BeeUITransitionTypeCube,
    BeeUITransitionTypeFade,
    BeeUITransitionTypeFlip,
    BeeUITransitionTypePush
} BeeUITransitionType;

@interface UIView(Transition)
//@property (nonatomic, retain) BeeUITransition *	transition;

- (void)transitionFade;
- (void)transitionFade:(BeeUITransitionDirection)from;

- (void)transitionCube;
- (void)transitionCube:(BeeUITransitionDirection)from;

- (void)transitionPush;
- (void)transitionPush:(BeeUITransitionDirection)from;

- (void)transitionFlip;
- (void)transitionFlip:(BeeUITransitionDirection)from;
@end
