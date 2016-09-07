//
//  ViewController.m
//  PushTransitionDemo
//
//  Created by 谢威 on 16/9/7.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"
@interface ViewController (){
    UIButton *button;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"第一页";
     self.view.backgroundColor = [UIColor whiteColor];
    
    button = ({
    UIButton   *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 100, 100);
        btn.center = self.view.center;
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"第一页" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
     });
   
    
    
}
- (void)btnClick{
    PopViewController *vc = [[PopViewController alloc]init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
