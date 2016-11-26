//
//  HomeViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "HomeViewController.h"
#import "SkyHomeDataManager.h"
#import "TYTabButtonPagerController.h"
#import "SkyOtherViewController.h"
#import "SkyRecommendedViewController.h"
#import "SkyCategoryModel.h"
#import "SkyHomeDataManager.h"
#import "SkyOtherDataManager.h"

@interface HomeViewController ()<TYPagerControllerDataSource>
@property (nonatomic, strong) TYTabButtonPagerController *pagerController;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //左上角logo
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage: [UIImage imageNamed:@"img_nav_logo_77x20_"] forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 77, 20);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    [self addPagerController];
    [self configureTabButtonPager];
}

//MARK: - 添加视图
- (void)addPagerController
{
    TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc]init];
    pagerController.adjustStatusBarHeight = YES;
    pagerController.dataSource  = self;
    pagerController.barStyle    = TYPagerBarStyleCoverView;
    pagerController.cellSpacing = 8;
    
    pagerController.view.frame = self.view.bounds;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

- (void)configureTabButtonPager
{
    self.pagerController.normalTextColor   = HexRGB(0x5a5a5c);
    self.pagerController.selectedTextColor = HexRGB(0xf15b5a);
    self.pagerController.progressColor     = HexRGB(0xf1f1f1);
    self.pagerController.normalTextFont    =
    self.pagerController.selectedTextFont  = [UIFont systemFontOfSize:16.f];
}

//MARK: - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController
{
    return HomeDataManager.categoryInfo.count;
}

- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    SkyCategoryModel *model = [HomeDataManager.categoryInfo objectAtIndex:index];
    return model.name;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    SkyCategoryModel *model = [HomeDataManager.categoryInfo objectAtIndex:index];
    if (model.type == 1)
    {
        //推荐
        SkyRecommendedViewController *recommendedVC = [[SkyRecommendedViewController alloc]init];
        recommendedVC.moveToControllerBlock = ^(NSInteger index){
            //这里如果数据变化,会崩溃,毕竟上面标签是写死的 ~
            [_pagerController moveToControllerAtIndex:index animated:NO];
        };
        return recommendedVC;
    }else
    {   //其它
        SkyOtherViewController *otherVC = [[SkyOtherViewController alloc]init];
        otherVC.slug = model.slug;
        return otherVC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
