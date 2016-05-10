//
//  PresentSegue.m
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import "PresentSegue.h"

@implementation PresentSegue

- (void)perform {
//    [super perform];
    
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    
    [src presentViewController:dst animated:YES completion:nil];
}

@end
