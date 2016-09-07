//
//  XWPushTransitionManager.h
//  00---转场Demo
//
//  Created by 谢威 on 16/8/31.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    XWPushTransitionManagerPush,
    XWPushTransitionManagerPop
        
}XWPushTransitionManagerType;


@interface XWPushTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(XWPushTransitionManagerType)type;




@end
