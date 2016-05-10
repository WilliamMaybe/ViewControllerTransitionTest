# ViewControllerTransitionTest
终于是看起转场动画了，之前一直被各种delegate所害怕，是看着动画小王子的来制作的，不过文章好像很老了，demo里面也有一些错误
[小王子的转场博客](http://www.kittenyang.com/uiviewcontrollertransitioning/)	
![](./picture.gif)
##步骤
用storyboard建立两个ViewController
![](./picture1.png)
在这里直接食用segue的时候，kitten的demo中选择了custom segue，看了一下custom是需要`Custom segues must have a custom class`,需要继承一个UIStoryboardSegue并且实现

```	
-(void)perform {
	UIViewController *src = self.sourceViewController;
	UIViewController *dst = self.destinationViewController;
	[src presentViewController:dst animated:YES completion:nil];
}
```	
#下面开始制作动画
##第一步 UIViewControllerAnimatedTransitioning
创建一个**RotationPresentAnimation**继承于NSObject的类，实现协议**UIViewControllerAnimatedTransitioning**
协议中的2个方法

```obj-c
/// 返回动画时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
```

```obj-c
/// 转场时使用的动画效果，都会在这个方法中实现
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
```
实现2个方法

```obj-c
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
    
    /// 切换的转场视图都在containerView中实现
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
```

完成了2个方法之后在ViewController中加入相应的变量
```obj-c
@interface ViewController() <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong)RotationPresentAnimation *presentAnimation;

@end

@implemention ViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.presentAnimation = [[RotationPresentAnimation alloc] init];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioning Delegate
- (id<UIViewControllerAnimatedTransitioning>)animationCOntrollerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
	return self.presentAnimation;
}

@end

```
至此，present自定义动画就完成了。