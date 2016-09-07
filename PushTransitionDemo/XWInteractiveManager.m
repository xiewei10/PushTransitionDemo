//
//  XWInteractiveManager.m
//  00---转场Demo
//
//  Created by 谢威 on 16/8/31.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "XWInteractiveManager.h"

@interface XWInteractiveManager ()
@property (nonatomic,strong)UIViewController      *vc;

@end

@implementation XWInteractiveManager

-(instancetype)initWithViewController:(UIViewController *)VC{
    if (self == [super init] ) {
        self.vc = VC;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [VC.view addGestureRecognizer:pan];
        
        
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture{
    CGFloat persent = 0.;
    CGFloat  transitionX = [panGesture translationInView:panGesture.view].x;
    persent = transitionX / panGesture.view.frame.size.width;
    
    NSLog(@"完成比例%f",persent);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            // 手势开始
            // 标记是手势返回
            self.isInteractive = YES;
            [self.vc.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            // 系统自动帮我们计算转场度  太神奇
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            
        {
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.isInteractive = NO;
            if (persent > 0.4) {
                
                [self finishInteractiveTransition];
                
                
            }else{
                
                [self cancelInteractiveTransition];
                
            }
            break;
        }

           default:
            break;
    }
    
    
    
}


@end
