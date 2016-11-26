//
//  SkyRecommendedViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyRecommendedViewController.h"
#import "SkyRecommendedCollectionViewLayout.h"
#import "SkyCollectionViewCell.h"
#import "SkyHomeDataManager.h"
#import "SkyRecommendedHeadView.h"
#import "SkyCategoryModel.h"
#import "SkyLoveCollectionViewCell.h"
#import "SkyRefreshGifHeader.h"
#import "SkyLiveViewController.h"
#import "SkyLoveLiveViewController.h"

@interface SkyRecommendedViewController ()

@end

@implementation SkyRecommendedViewController

static NSString * const reuseIdentifier     = @"RecommendedViewCell";
static NSString * const headReuseIdentifier = @"SkyRecommendedHeadView";
static NSString * const loveReuseIdentifier = @"SkyLoveCollectionViewCell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing      = 10;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40.f);
    //layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 10.f)
    layout.collectionView.showsHorizontalScrollIndicator = NO;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = Home_List_BGColor;

    // Register cell classes
    [self.collectionView registerClass:[SkyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[SkyLoveCollectionViewCell class] forCellWithReuseIdentifier:loveReuseIdentifier];
    [self.collectionView registerClass:[SkyRecommendedHeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:headReuseIdentifier];

    [self getListData];
    [self configureRefres]; //只有下拉刷新
    [self showLoading:nil];
}

//MARK: - 创建下拉
- (void)configureRefres
{
    MJWeakSelf
    self.collectionView.mj_header = [SkyRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf getListData];
    }];
}

//MARK:- 获取数据
- (void)getListData
{
    [HomeDataManager getRecommendedData:^(int code, NSString *msg) {
        [self hideLoading];
        [self.collectionView.mj_header endRefreshing];
        if (code == RES_CODE_OK) {
            [self.collectionView reloadData];
        }else
            [self sky_make:msg];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return HomeDataManager.recommendedDataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SkyCategoryModel *model = [HomeDataManager.recommendedDataList objectAtIndex:section];
    return model.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    SkyCategoryModel *model = [HomeDataManager.recommendedDataList objectAtIndex:indexPath.section];
    SkyCategoryListModel *listModel = [model.list objectAtIndex:indexPath.row];
    if ( model.slug != nil && [model.slug isEqualToString:@"love"])//有颜就有爱(一切) ~
    {
        SkyLoveCollectionViewCell *loveCell = [collectionView dequeueReusableCellWithReuseIdentifier:loveReuseIdentifier forIndexPath:indexPath];
        loveCell.categoryListModel = listModel;
        cell = loveCell;
    }else
    {
        SkyCollectionViewCell *otheCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        otheCell.backgroundColor   =
        otheCell.titleBGColor      = [UIColor whiteColor];
        otheCell.categoryListModel = listModel;
        cell = otheCell;
    }

    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SkyCategoryModel *model = [HomeDataManager.recommendedDataList objectAtIndex:indexPath.section];
    if (model.slug != nil && [model.slug isEqualToString:@"love"]) {
        return CGSizeMake((SCREEN_WIDTH-30)/2, 172);
    }return CGSizeMake((SCREEN_WIDTH-30)/2, 155);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self sky_make:@"目前只写了 颜值控   PS:有颜就是🐂啊 ~ "];
    SkyCategoryModel *model = [HomeDataManager.recommendedDataList objectAtIndex:indexPath.section];
    SkyCategoryListModel *listModel = [model.list objectAtIndex:indexPath.row];

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

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        SkyRecommendedHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseIdentifier forIndexPath:indexPath];
        headView.backgroundColor = [UIColor whiteColor];
        SkyCategoryModel *model = [HomeDataManager.recommendedDataList objectAtIndex:indexPath.section];
        headView.title = model.name;
        reusableview = headView;
        @weakify(self)
        headView.selectedLookBlack = ^(){
            if (weak_self.moveToControllerBlock) {
                weak_self.moveToControllerBlock(indexPath.section+1);
            }
        };
    }else if(kind == UICollectionElementKindSectionFooter)
    {
       
    }
    return reusableview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
