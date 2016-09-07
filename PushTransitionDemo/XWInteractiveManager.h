//
//  XWInteractiveManager.h
//  00---转场Demo
//
//  Created by 谢威 on 16/8/31.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  手势驱动管理者
 */
@interface XWInteractiveManager : UIPercentDrivenInteractiveTransition

/**该bool值 用来判断是手势返回 还是pop返回*/
@property(nonatomic,assign)BOOL  isInteractive;


- (instancetype)initWithViewController:(UIViewController *)VC;
@end
