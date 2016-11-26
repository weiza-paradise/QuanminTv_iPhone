//
//  SkyNavigationViewController.m
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyNavigationViewController.h"

@interface SkyNavigationViewController ()

@end

@implementation SkyNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavBarTheme];
}

- (void)configureNavBarTheme
{
    self.navigationBar.tintColor = [UIColor whiteColor];
    // 设置导航栏的标题颜色，字体
    NSDictionary* textAttrs = @{    NSFontAttributeName:
                                    [UIFont systemFontOfSize:18.f],
                                };
    [self.navigationBar setTitleTextAttributes:textAttrs];
    //设置导航栏的背景图片
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    //导航栏底部阴影
    [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithRed:233.0/255.0 green:237.0/255.0 blue:240.0/255.0 alpha:1.0]]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count)
    {   // 隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        // 自定义返回按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"navigationBar_backButton_icon_30x30_"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationBar_backButton_pressIcon_30x30_"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
