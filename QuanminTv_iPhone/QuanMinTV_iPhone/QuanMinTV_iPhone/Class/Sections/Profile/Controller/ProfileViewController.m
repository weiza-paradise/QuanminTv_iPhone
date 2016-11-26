//
//  ProfileViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ProfileViewController.h"
static CGFloat ParallaxHeaderHeight = 230;

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  */
@property (nonatomic, weak)   UITableView   *profileTableView;
/** 添加动图 */
@property (nonatomic, strong) YYAnimatedImageView *imageView;
/** 约束 */
@property (nonatomic, strong) MASConstraint *headerHeightConstraint;

@end

@implementation ProfileViewController

- (UITableView*)profileTableView
{
    if (!_profileTableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self.view addSubview:tableView];
        tableView.contentInset = UIEdgeInsetsMake(ParallaxHeaderHeight, 0, 0, 0);

        [tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _profileTableView = tableView;
    }
    return _profileTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadView];
    [self sky_make:@"哇,下拉有惊喜 ~ "];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.imageView) {
        NSString *image = [NSString stringWithFormat:@"%d.gif",arc4random()%20+1];
        self.imageView.image = [YYImage imageNamed:image];
    }
}

//MARK: - UITableViewDataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat:@"%td",indexPath.row];
    return cell;
}

- (void)_loadView
{
    YYImage *image = [YYImage imageNamed:@"1.gif"];
    _imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    _imageView.centerX = self.view.width / 2;
    [self.view insertSubview:_imageView belowSubview:self.profileTableView];

    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideTop);
        _headerHeightConstraint = make.height.equalTo(@(ParallaxHeaderHeight));
    }];
    //添加kvo
    [self.profileTableView addObserverBlockForKeyPath:@"contentOffset" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        CGPoint contentOffset = ((NSValue*)newVal).CGPointValue;
        if (contentOffset.y < -ParallaxHeaderHeight) {
            _headerHeightConstraint.equalTo(@(-contentOffset.y));
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
