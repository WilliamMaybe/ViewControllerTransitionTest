//
//  PanInteractiveTransition.h
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanInteractiveTransition : UIPercentDrivenInteractiveTransition

- (void)panToDismiss:(UIViewController *)viewController;

@property (nonatomic, readonly) BOOL interacting;

@end
