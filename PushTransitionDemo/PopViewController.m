//
//  PopViewController.m
//  PushTransitionDemo
//
//  Created by 谢威 on 16/9/7.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "PopViewController.h"
#import "XWPushTransitionManager.h"
#import "XWInteractiveManager.h"
@interface PopViewController ()
@property (nonatomic,strong)XWInteractiveManager  *manager;
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor purpleColor];
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[XWInteractiveManager alloc]initWithViewController:self];
        
    }
    return self;
}

#pragma mark -- 代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XWPushTransitionManager transitionWithType:operation == UINavigationControllerOperationPush ? XWPushTransitionManagerPush : XWPushTransitionManagerPop];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
    // 这里要判断 是pop返回 还是手势返回
    return self.manager.isInteractive?self.manager:nil;
}



@end
