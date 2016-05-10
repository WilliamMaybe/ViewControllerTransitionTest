//
//  PresentedViewController.h
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PresentedViewController;

@protocol PresentedVCDelegate <NSObject>

- (void)didPresentedVC:(PresentedViewController *)viewController;

@end

@interface PresentedViewController : UIViewController

@property (nonatomic, weak) id<PresentedVCDelegate> delegate;

@end
