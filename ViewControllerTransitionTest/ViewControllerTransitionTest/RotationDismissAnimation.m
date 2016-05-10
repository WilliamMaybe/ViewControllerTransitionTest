//
//  RotationDismissAnimation.m
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import "RotationDismissAnimation.h"

@implementation RotationDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 最初始时的位置
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    // 最终需要消失的位置
    CGRect finalFrame = CGRectOffset(initFrame, 0, [UIScreen mainScreen].bounds.size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    // 将待显示的toVC视图移至后方显示，看到的就是fromVC在前，toVC在后
    [containerView sendSubviewToBack:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0.0
//         usingSpringWithDamping:0.4
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveLinear animations:^
//    {
//        fromVC.view.frame = finalFrame;
//                            
//    }
//                     completion:^(BOOL finished)
//    {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
}

@end
