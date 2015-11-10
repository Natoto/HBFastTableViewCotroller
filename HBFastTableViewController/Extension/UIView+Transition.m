//
//  UIView+Transition.m
//  pengmi
//
//  Created by 星盛 on 15/3/26.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import "UIView+Transition.h"

@implementation UIView(Transition)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
 
- (void)transitionCube
{
    [self transitionCube:BeeUITransitionDirectionRight];
}

- (void)transitionCube:(BeeUITransitionDirection)from
{
    [self transiteFor:self direction:from];
}

- (void)transitionPush
{
    [self transitionPush:BeeUITransitionDirectionRight];
}

- (void)transitionPush:(BeeUITransitionDirection)from
{
    [self transiteFor:self direction:from];
}

- (void)transitionFlip
{
    [self transitionFlip:BeeUITransitionDirectionRight];
}

- (void)transitionFlip:(BeeUITransitionDirection)from
{
    [self transiteFor:self direction:from];
}



- (void)transitionFade
{
    [self transitionFade:BeeUITransitionDirectionRight];
}

- (void)transitionFade:(BeeUITransitionDirection)from
{
    [self transiteFor:self direction:from];
}


- (void)transiteFor:(UIView *)container direction:(BeeUITransitionDirection)direction
{
    CATransition * animation = [CATransition animation];
    if ( animation )
    {
        [animation setDuration:0.2f];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [animation setType:@"fade"];
        [animation setSubtype:[self CATransitionFrom:direction]];
        [animation setRemovedOnCompletion:YES];
        
        //		[container.layer removeAnimationForKey:@"fade"];
        [container.layer addAnimation:animation forKey:@"fade"];
    }
}

- (NSString *)CATransitionFrom:(BeeUITransitionDirection)dir;
{
    if ( dir == BeeUITransitionDirectionRight )
    {
        return kCATransitionFromRight;
    }
    else if ( dir == BeeUITransitionDirectionLeft )
    {
        return kCATransitionFromLeft;
    }
    else if ( dir == BeeUITransitionDirectionTop )
    {
        return kCATransitionFromTop;
    }
    else if ( dir == BeeUITransitionDirectionBottom )
    {
        return kCATransitionFromBottom;
    }
    
    return kCATransitionFromRight;
}


@end
