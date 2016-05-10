//
//  RotationPresentAnimation.m
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import "RotationPresentAnimation.h"

@implementation RotationPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 要显示的VC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 要显示VC最终的位置
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    // 设置要显示VC的初始位置
    toVC.view.frame = CGRectOffset(finalRect, 0, -[UIScreen mainScreen].bounds.size.height);
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear animations:^
    {
        toVC.view.frame = finalRect;
    }
    
                     completion:^(BOOL finished)
    {
        [transitionContext completeTransition:YES];
    }];
}

@end
