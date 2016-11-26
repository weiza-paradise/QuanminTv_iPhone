//
//  SkyLiveViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/24.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLiveViewController.h"
#import "SkyLivePlayerView.h"
#import "TYTabButtonPagerController.h"

@interface SkyLiveViewController ()<TYPagerControllerDataSource>
/** 滑动视图 */
@property (nonatomic, weak)   TYTabButtonPagerController *pagerController;
/** 直播视图 */
@property (nonatomic, strong) SkyLivePlayerView *playerView;
/** 滑动视图标题 */
@property (nonatomic, strong) NSArray *categoryList;

@end

@implementation SkyLiveViewController

- (NSArray*)categoryList
{
    if (!_categoryList) {
        _categoryList = @[@"聊天",@"排行",@"守候"];
    }
    return _categoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configurePlayerView];
    [self addPagerController];
    [self configureTabButtonPager];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_playerView) {
        [_playerView playerShutdown];
        [_playerView removeObserver];
    }
}

//MARK: - 加载视频播放视图
- (void)configurePlayerView
{
    _playerView = [[SkyLivePlayerView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16) ContentURLString:Live_url(self.uid)];
    _playerView.orientationBackBlock = ^(){
        if([SkyStatusHelper isOrientationLandscape])
            [SkyStatusHelper forceOrientation: UIInterfaceOrientationPortrait];
        else
            [SkyStatusHelper forceOrientation: UIInterfaceOrientationLandscapeRight];
    };
    @weakify(self);
    _playerView.backButtonBlock = ^(){
        if([SkyStatusHelper isOrientationLandscape])
            [SkyStatusHelper forceOrientation: UIInterfaceOrientationPortrait];
        else
            [weak_self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:_playerView];
}

//MARK: - 添加视图
- (void)addPagerController
{
    TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc]init];
    pagerController.dataSource  = self;
    pagerController.barStyle    = TYPagerBarStyleProgressBounceView;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    [pagerController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.equalTo(_playerView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
    }];
    _pagerController = pagerController;
}

- (void)configureTabButtonPager
{
    self.pagerController.normalTextColor   = HexRGB(0x9f9f9f);
    self.pagerController.selectedTextColor =
    self.pagerController.progressColor     = HexRGB(0xf25c5d);
    self.pagerController.normalTextFont    =
    self.pagerController.selectedTextFont  = [UIFont systemFontOfSize:16.f];
    self.pagerController.cellWidth         = SCREEN_WIDTH/3;
}

//MARK: - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController
{
    return self.categoryList.count;
}

- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
  return [self.categoryList objectAtIndex:index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    UIViewController *view = [[UIViewController alloc]init];
    view.view.backgroundColor = RANDOMCOLOR;
    return view;
}

//MARK: - 视图旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if ([SkyStatusHelper isOrientationLandscape]) {
             [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                 _playerView.frame = self.view.bounds;
             } completion:nil];
         }
         else {
             [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                 _playerView.frame = CGRectMake(0, 20, SCREEN_WIDTH, self.view.bounds.size.width * 9 / 16);
             } completion:nil];
         }
     } completion: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
