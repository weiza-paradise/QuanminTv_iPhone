//
//  ColumnViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ColumnViewController.h"
#import "ColumnDataManager.h"
#import "ColumnCell.h"
#import "SkyRefreshGifHeader.h"
#import "SkyOtherViewController.h"

@interface ColumnViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**  */
@property (nonatomic, weak) UICollectionView *columnView;
@end

static NSString * const reuseIdentifier = @"columnCell";

@implementation ColumnViewController

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
    [COLUMN_MANAGER requestColumnListData:^(int code, NSString *msg) {
        [self hideLoading];
        [self.columnView.mj_header endRefreshing];
        if (code == RES_CODE_OK)
            [self.columnView reloadData];
        else
            [self sky_make:msg];
    }];
}

//MARK: - 创建主视图
- (void)configureCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    layout.minimumInteritemSpacing = 6.f;
    layout.minimumLineSpacing      = 6.f;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 12*2 - 6*2)/3 , 152);
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = Home_List_BGColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _columnView = collectionView;
    [collectionView registerClass:[ColumnCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    return COLUMN_MANAGER.columnListData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = RANDOMCOLOR;
    ColumnModel *model = [COLUMN_MANAGER.columnListData objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self sky_make:@"暂时没写 亲 ~ "];
    ColumnModel *model = [COLUMN_MANAGER.columnListData objectAtIndex:indexPath.row];
    SkyOtherViewController *otherVC = [[SkyOtherViewController alloc]init];
    otherVC.slug = model.slug;
    otherVC.navTitle = model.name;
    [self.navigationController pushViewController:otherVC animated:YES];
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
