//
//  SkyLoveLiveLayerView.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/22.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLoveLiveLayerView.h"
#import "SkyLoveLiveLayerBottomTool.h"
#import "SkyCategoryModel.h"

@interface SkyLoveLiveLayerView ()<UITableViewDelegate,UITableViewDataSource>

//先写这几个,毕竟这里如果要分,会有好几个单独的view,实现起来也会更复杂,这里先简单写下

/** 聊天TableView */
@property (nonatomic, strong) UITableView *imTableView;
/** 头像  */
@property (nonatomic, strong) UIImageView *avatarImage;
/** 底部工具栏 */
@property (nonatomic, strong) SkyLoveLiveLayerBottomTool *bottomToolView;
/** 定时器用于模拟聊天 */
@property (nonatomic, strong) NSTimer     *timer;
/** 粒子动画 */
@property(nonatomic, weak)    CAEmitterLayer *emitterLayer;
/////////数据
/** im数据源 */
@property (nonatomic, strong) NSMutableArray *imTableDataSoure;
@property (nonatomic, strong) NSArray        *dataList;
@end

@implementation SkyLoveLiveLayerView

- (NSArray*)dataList
{
    if (!_dataList) {
        _dataList = [NSArray arrayWithObjects:@"美女",@"你眼睛好大啊 ~",@"能动手就别吵吵",@"你的腿好白好长😋",@"😆别逗乐~",@"哪有啦,人家只是美美哒~",@"你个人妖王",@"我是要成为主播男人的男人~😂",@"看到你我的心就凌乱了~",@"主播你是🐒请来的逗比吗~",@"哈哈哈哈哈哈 ~ ",@"都别当我看球~",@"主播,这么美~~~", nil];
    }
    return _dataList;
}

- (NSMutableArray*)imTableDataSoure
{
    if (!_imTableDataSoure) {
        _imTableDataSoure = [[NSMutableArray alloc]initWithObjects:@"主播好美的说 ~ ",@"主播求报大腿 ~ 😄", nil];
    }
    return _imTableDataSoure;
}

- (UIImageView*)avatarImage
{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc]init];
        _avatarImage.clipsToBounds = YES;
        _avatarImage.contentMode   = UIViewContentModeScaleAspectFill;
    }
    return _avatarImage;
}

- (SkyLoveLiveLayerBottomTool*)bottomToolView
{
    if (!_bottomToolView) {
        @weakify(self)
        _bottomToolView = [[SkyLoveLiveLayerBottomTool alloc]init];
        _bottomToolView.top    = (SCREEN_HEIGHT - 50.f);
        _bottomToolView.height = 50.f;
        _bottomToolView.left   = 0 ;
        _bottomToolView.width  = SCREEN_WIDTH;
        [_bottomToolView setClickBottomToolBlock:^(LayerBottomToolType type) {
            switch (type) {
                case LayerBottomToolTypeMessage:
                    [weak_self sky_make:@"发消息"];
                    break;
                case LayerBottomToolTypeShare:
                    [weak_self sky_make:@"分享"];
                    break;
                case LayerBottomToolTypeGift:
                    [weak_self sky_make:@"送礼物"];
                    break;
                case LayerBottomToolTypePraise:
                {
                    [weak_self sky_make:@"点赞"];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _bottomToolView;
}

- (CAEmitterLayer *)emitterLayer
{
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH-30,SCREEN_HEIGHT-50);
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        //    _emitterLayer.preservesDepth = YES;
        NSMutableArray *imageList = [NSMutableArray arrayWithObjects:
                                 @"img_player__like_blue_35x30_",
                                 @"img_player__like_blue1_35x30_",
                                 @"img_player__like_emoji_favorite_35x35_",
                                 @"img_player__like_emoji_glasses_35x35_",
                                 @"img_player__like_emoji_happy_35x35_",
                                 @"img_player__like_emoji_Tongue_35x35_",
                                 @"img_player__like_orange_35x30_",
                                 @"img_player__like_purple_35x30_",
                                 @"img_player__like_red_35x30_",
                                 @"img_player__like_yellow_35x30_", nil];
        NSMutableArray *array = [NSMutableArray array];
        // 创建粒子
        for (int i = 0; i<imageList.count; i++) {
            // 发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            // 粒子的创建速率，默认为1/s
            stepCell.birthRate = 1;
            // 粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            UIImage *image = [UIImage imageNamed:[imageList objectAtIndex:i]];
            // 粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/6;
            // 缩放比例
            stepCell.scale = 0.3;
            [array addObject:stepCell];
        }
        
        emitterLayer.emitterCells = array;
        [self.layer addSublayer:emitterLayer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

- (UITableView*)imTableView
{
    if (!_imTableView) {
        _imTableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _imTableView.rowHeight  = 30;
        _imTableView.delegate   = self;
        _imTableView.dataSource = self;
        _imTableView.showsVerticalScrollIndicator   = NO;
        _imTableView.showsHorizontalScrollIndicator = NO;
        _imTableView.backgroundColor = [UIColor clearColor];
        _imTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _imTableView.tableHeaderView = [[UIView alloc]init];
        //倒过来 ~
        _imTableView.transform = CGAffineTransformMakeScale(1, -1);
    }
    return _imTableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个滑动手势
        @weakify(self)
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [weak_self panGestureView:sender];
        }]];
        
        [self addSubview:self.avatarImage];
        [self.avatarImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@15);
            make.top.mas_equalTo(@38);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
        
        [self addSubview:self.imTableView];
        [self.imTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@8);
            make.bottom.mas_equalTo(@(-50));
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2+100, 200));//先写死
        }];
        
        //写个定时器去刷新聊天界面,毕竟demo
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
            NSString *content = [self.dataList objectAtIndex:arc4random()%self.dataList.count];
            [weak_self.imTableDataSoure insertObject:content atIndex:0];
            [weak_self.imTableView insertRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationTop];
        } repeats:YES];

        //添加toolview
        [self addSubview:self.bottomToolView];
        [self.emitterLayer setHidden:NO];
    }
    return self;
}

//MARK: - UITableViewControllerDataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imTableDataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = HexRGB(0xfefaf7);
        cell.textLabel.font      = [UIFont systemFontOfSize:12.f];
        //倒过来 ~
        cell.textLabel.transform = CGAffineTransformMakeScale(1, -1);
    }
    cell.textLabel.text = [self.imTableDataSoure objectAtIndex:indexPath.row];
    return cell;
}

- (void)setModel:(SkyCategoryListModel *)model
{
    _model = model;
    //头像圆角
    [self.avatarImage setImageWithURL:model.avatar
                        placeholder:nil
                            options:kNilOptions
                            manager:[SkyStatusHelper avatarImageManager]                           progress:nil
                          transform:nil
                         completion:nil];
}

//MARK: - 手势
- (void)panGestureView:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan translationInView:self];
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        if (point.x <= 0 )  return;
        CGRect rect = self.frame;
        rect.origin.x = point.x;
        self.frame = rect;
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x < SCREEN_WIDTH/4)
        {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect = self.frame;
                rect.origin.x = 0;
                self.frame = rect;
            }];
        }else
        {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect = self.frame;
                rect.origin.x = SCREEN_WIDTH;
                self.frame = rect;
            }];
        }
    }
}

//MARK: - 取消定时器
- (void)removeTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
