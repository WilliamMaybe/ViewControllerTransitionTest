//
//  PanInteractiveTransition.m
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import "PanInteractiveTransition.h"

@interface PanInteractiveTransition ()

@property (nonatomic, strong) UIViewController *presentedVC;
@property (nonatomic, assign) BOOL shouldComplete;

@end

@implementation PanInteractiveTransition

- (void)panToDismiss:(UIViewController *)viewController {
    self.presentedVC = viewController;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self.presentedVC.view addGestureRecognizer:panGesture];
}

- (CGFloat)completionSpeed {
    return (1 - self.percentComplete) * self.duration;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _interacting = YES;
            [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = MAX(translation.y / 400.0, 0);
            percent = MIN(percent, 1);
            self.shouldComplete = percent > 0.5;
            
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            _interacting = NO;
            if (!self.shouldComplete || gesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

@end
