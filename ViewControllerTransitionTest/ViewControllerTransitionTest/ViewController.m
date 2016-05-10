//
//  ViewController.m
//  ViewControllerTransitionTest
//
//  Created by williamzhang on 16/5/9.
//  Copyright © 2016年 williamzhang. All rights reserved.
//

#import "ViewController.h"
#import "PresentedViewController.h"
#import "RotationPresentAnimation.h"
#import "RotationDismissAnimation.h"
#import "PanInteractiveTransition.h"

@interface ViewController () <UIViewControllerTransitioningDelegate, PresentedVCDelegate>

@property (nonatomic, strong) RotationPresentAnimation *presentAnimation;

@property (nonatomic, strong) RotationDismissAnimation *dismissAnimation;
@property (nonatomic, strong) PanInteractiveTransition *panInteractiveTransition;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.presentAnimation = [[RotationPresentAnimation alloc] init];
        self.dismissAnimation = [[RotationDismissAnimation alloc] init];
        self.panInteractiveTransition = [[PanInteractiveTransition alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)presentClicked:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PresentedViewController *pvc = [storyboard instantiateViewControllerWithIdentifier:@"Presented"];
    pvc.delegate = self;
    pvc.transitioningDelegate = self;
    
    [self.panInteractiveTransition panToDismiss:pvc];
    
    [self presentViewController:pvc animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PresentedViewController *pvc = segue.destinationViewController;
    pvc.delegate = self;
    pvc.transitioningDelegate = self;
    
    [self.panInteractiveTransition panToDismiss:pvc];
}

#pragma mark - PresentedVC Delegate
- (void)didPresentedVC:(PresentedViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioning Delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.panInteractiveTransition.interacting ? self.panInteractiveTransition : nil;
}

@end
