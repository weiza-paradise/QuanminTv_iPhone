//
//  SkyOtherViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyOtherViewController.h"
#import "SkyRecommendedCollectionViewLayout.h"
#import "SkyCollectionViewCell.h"
#import "SkyOtherDataManager.h"
#import "SkyCategoryModel.h"
#import "SkyLoveCollectionViewCell.h"
#import "SkyLoveLiveViewController.h"
#import "SkyRefreshGifHeader.h"
#import "SkyLiveViewController.h"

@interface SkyOtherViewController ()
@property (nonatomic, assign) NSInteger curIndexPage;
@property (nonatomic, strong) NSMutableArray *feedListData;
@end

@implementation SkyOtherViewController

static NSString * const reuseIdentifier     = @"OtherViewCell";
static NSString * const loveReuseIdentifier = @"otherLoveCollectionViewCell";

- (NSMutableArray*)feedListData
{
    if (!_feedListData) {
        _feedListData = [[NSMutableArray alloc]init];
    }
    return _feedListData;
}

- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[SkyRecommendedCollectionViewLayout alloc]init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = Home_List_BGColor;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = self.navTitle;
    // Register cell classes
    [self.collectionView registerClass:[SkyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[SkyLoveCollectionViewCell class] forCellWithReuseIdentifier:loveReuseIdentifier];
    [self loadData];
    [self configureRefres];
    [self showLoading:nil];

    // Do any additional setup after loading the view.
}

//MARK: - 创建下拉
- (void)configureRefres
{
    MJWeakSelf
    self.collectionView.mj_header = [SkyRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

- (void)loadData
{
    BOOL isPlay = NO;
    isPlay = [self.slug isEqualToString:@"play"] ? YES : NO ; //是否是全部
    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
                         UrlString:isPlay ? HOME_ALL_LIST : HOME_OTHER_LIST(self.slug)
                        Parameters:nil
                      SuccessBlock:^(id responseObject) {
                          [self.collectionView.mj_header endRefreshing];
                          [self hideLoading];
                          [self.feedListData removeAllObjects];
                          SkyOtherModel * model = [SkyOtherModel modelWithJSON:responseObject];
                          [model.data enumerateObjectsUsingBlock:^(SkyCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                              [self.feedListData addObject:obj];
                          }];
                          if (self.feedListData.count == 0)
                              [self sky_make:@"亲,没有数据 ~ "];
                          [self.collectionView reloadData];
    } FailureBlock:^(NSError *error) {
        [self sky_make:@"亲,网络有问题 ~"];
        [self.collectionView.mj_header endRefreshing];
        [self hideLoading];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.feedListData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    SkyCategoryListModel *listModel = [self.feedListData objectAtIndex:indexPath.row];

    if ( self.slug != nil && [self.slug isEqualToString:@"love"])
    {
        SkyLoveCollectionViewCell *loveCell = [collectionView dequeueReusableCellWithReuseIdentifier:loveReuseIdentifier forIndexPath:indexPath];
        loveCell.categoryListModel = listModel;
        cell = loveCell;
    }else
    {
        SkyCollectionViewCell *otheCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        otheCell.categoryListModel = listModel;
        cell = otheCell;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.slug != nil && [self.slug isEqualToString:@"love"]) {
        return CGSizeMake((SCREEN_WIDTH-30)/2, 172);
    }return CGSizeMake((SCREEN_WIDTH-30)/2, 155);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SkyCategoryListModel *listModel = [self.feedListData objectAtIndex:indexPath.row];
    
    if (![listModel.categorySlug isEqualToString:@"love"]) {
        SkyLiveViewController *liveViewController = [[SkyLiveViewController alloc]init];
        liveViewController.uid = listModel.uid;
        [self.navigationController pushViewController:liveViewController animated:YES];
    }else
    {
        SkyLoveLiveViewController *loveLiveViewController = [[SkyLoveLiveViewController alloc]init];
        loveLiveViewController.uid   = listModel.uid;
        loveLiveViewController.thumb = listModel.thumb;
        loveLiveViewController.model = listModel;
        [self.navigationController pushViewController:loveLiveViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
