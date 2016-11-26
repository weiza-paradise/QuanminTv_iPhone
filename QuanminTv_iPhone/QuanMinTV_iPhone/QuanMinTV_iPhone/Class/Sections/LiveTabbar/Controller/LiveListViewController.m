//
//  LiveListViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "LiveListViewController.h"
#import "SkyRefreshGifHeader.h"
#import "LiveListManager.h"
#import "SkyCollectionViewCell.h"
#import "SkyCategoryModel.h"
#import "SkyLiveViewController.h"
#import "SkyLoveLiveViewController.h"

@interface LiveListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**  */
@property (nonatomic, weak) UICollectionView *liveListView;

@end

static NSString * const reuseIdentifier = @"LiveListCell";

@implementation LiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Home_List_BGColor;
    [self configureCollectionView];
    [self getListData];
    [self showLoading:@""];
}

//MARK: - 获取数据
- (void)getListData
{
    [LIVELIST_MANAGER requestLiveListData:^(int code, NSString *msg) {
        [self hideLoading];
        [self.liveListView.mj_header endRefreshing];
        if (code == RES_CODE_OK)
            [self.liveListView reloadData];
        else
            [self sky_make:msg];
    }];
}

//MARK: - 创建主视图
- (void)configureCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, 155);
    layout.minimumLineSpacing      = 10;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = Home_List_BGColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _liveListView = collectionView;
    [collectionView registerClass:[SkyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //下拉刷新
    MJWeakSelf
    collectionView.mj_header = [SkyRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf getListData];
    }];
    
    [collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//MARK: - UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return LIVELIST_MANAGER.liveListData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SkyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    SkyCategoryListModel *listModel = [LIVELIST_MANAGER.liveListData objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = Home_List_BGColor;
    cell.categoryListModel = listModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self sky_make:@"暂时没写 亲 ~ "];
    SkyCategoryListModel *listModel = [LIVELIST_MANAGER.liveListData objectAtIndex:indexPath.row];
    
    if (![listModel.categorySlug isEqualToString:@"love"]) {
        SkyLiveViewController *liveViewController = [[SkyLiveViewController alloc]init];
        liveViewController.uid = listModel.uid;
        [self.navigationController pushViewController:liveViewController animated:YES];
    }else
    {
        SkyLoveLiveViewController *loveLiveViewController = [[SkyLoveLiveViewController alloc]init];
        loveLiveViewController.uid = listModel.uid;
        loveLiveViewController.thumb = listModel.thumb;
        [self.navigationController pushViewController:loveLiveViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
