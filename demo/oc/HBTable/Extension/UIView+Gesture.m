//
//  UIView+Gesture.m
//  JXL
//
//  Created by hb on 15/4/25.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "UIView+Gesture.h"

@implementation UIView(Gesture)


-(void)addTapGesture_to_resignFirstResponder
{
    UITapGestureRecognizer * tapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view_Tap_resign:)];
    [self addGestureRecognizer:tapGesture];
}

-(void)view_Tap_resign:(id)sender
{
    NSArray * subview=[self subviews];
    [subview enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
        
        if ([[obj class] isSubclassOfClass:[UITextField class]]) {
            if ([obj isFirstResponder]) {
                [obj resignFirstResponder];
            }
        }
        if ([[obj class] isSubclassOfClass:[UITextView class]]) {
            if ([obj isFirstResponder]) {
                [obj resignFirstResponder];
            }
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
