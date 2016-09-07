//
//  XWPushTransitionManager.m
//  00---转场Demo
//
//  Created by 谢威 on 16/8/31.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "XWPushTransitionManager.h"
#define Time 2
@interface XWPushTransitionManager ()


@property (nonatomic, assign) XWPushTransitionManagerType type;


@end

@implementation XWPushTransitionManager

+ (instancetype)transitionWithType:(XWPushTransitionManagerType)type{
    return [[self alloc]initWithTransitionType:type];
    
}
- (instancetype)initWithTransitionType:(XWPushTransitionManagerType)type{
    self = [super init];
    if (self) {
        _type = type;
        
    }
    return self;
}



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return Time;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    switch (self.type) {
        case XWPushTransitionManagerPush:
            [self doPushAnimation:transitionContext];
            break;
            
        case XWPushTransitionManagerPop:
            [self doPopAnimation:transitionContext];
            break;

        default:
            break;
    }
    
    
}
/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self ThrerDPushAnimation:transitionContext];
   
}


/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self ThrerDPopAnimation:transitionContext];
    
    
    
}
#pragma mark ------ 3D翻转
#pragma mark --- push 动画
- (void)ThrerDPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 将要转场出来的view
    UIView *toView =[transitionContext viewForKey:UITransitionContextToViewKey];
    // 当前的view
    UIView *formView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    // 转场的容器
    UIView *contaniView = [transitionContext containerView];
    contaniView.backgroundColor = [UIColor orangeColor];


    CATransform3D percatier = CATransform3DIdentity;
    // 设置m34 才有立体效果
    percatier.m34 = -1.0/500;
    
    //sublayerTranform
    // 设置了父视图的sublayerTranform 子视图就都有这个transform
    contaniView.layer.sublayerTransform = percatier;
    
    
    [contaniView  addSubview:toView];
    [contaniView  addSubview:formView];
    
    //toview 默认旋转90
    CATransform3D tranform1 = CATransform3DMakeRotation(-M_PI_2,0,1,0);
    toView.layer.transform = tranform1;
    
    
    // formview 的旋转角度 也是90  当formview旋转到90度时候 移除formview  并且toview开始动画
    // 其实2个view 各自只旋转了90度
    CATransform3D tranform2 = CATransform3DMakeRotation(M_PI_2,0,1,0);
    
    // 关键帧动画
    // StartTime:动画开始时间         取值0-1 指的是比例
    // relativeDuration: 动画持续时间 取值0-1 指的是比例
    [UIView animateKeyframesWithDuration:Time delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            // 当前的view 旋转90度
            formView.layer.transform = tranform2;
        }];
        
        // formview 动画完成后 toView 进行动画
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            toView.layer.transform = CATransform3DIdentity;

            
        }];
        
    } completion:^(BOOL finished) {
         // 动画完成之后 要告诉系统 转场完成了 不然会出现bug
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [formView removeFromSuperview];
        
    }];

    
    
}
#pragma mark --- pop 动画
- (void)ThrerDPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIView *toView   =[transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *formView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *contaniView = [transitionContext containerView];
    contaniView.backgroundColor = [UIColor   orangeColor];
    
    //sublayerTranform
    // 设置了父视图的sublayerTranform 姿势图就不用设置了
    
    
    CATransform3D percatier = CATransform3DIdentity;
    percatier.m34 = -1.0/500;
    contaniView.layer.sublayerTransform = percatier;
    
    // 将当前view 截图
    // afterUpdates参数表示是否在所有效果应用在视图上了以后再获取快照。例如，如果该参数为NO，则立马获取该视图现在状态的快照，反之，以下代码只能得到一个空白快照：
    UIView *tempView = [formView snapshotViewAfterScreenUpdates:NO];
    tempView.frame   =  formView.bounds;
    [contaniView     addSubview:tempView];
    [contaniView     addSubview:toView];
    formView.hidden = YES;
    
    
    //toview 默认旋转90
    CATransform3D   tranform1 = CATransform3DMakeRotation(M_PI_2,0,1,0);
    toView.layer.transform = tranform1;
    
    // 这是formview 的旋转角度 也是90  当formview旋转到90度时候 移除formview 并且toview开始动画
    CATransform3D tranform2 = CATransform3DMakeRotation(-M_PI_2,0,1,0);
    
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5  animations:^{
            tempView.layer.transform = tranform2;
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            toView.layer.transform = CATransform3DIdentity;
            
            
        }];
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
         formView.hidden = YES;
         [tempView removeFromSuperview];
        
        // 由于加入了手势驱动  所有要判断转场是否取消
        if ([transitionContext transitionWasCancelled]){
            formView.hidden = NO;
            
            NSLog(@"取消了");
            
        }else{
            formView.hidden = YES;
            NSLog(@"成功了");
             [tempView removeFromSuperview];

        }
        
        
    }];
    
}




@end
