//
//  ViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/4.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "SDCycleScrollView.h"
//#import "LiveRoomViewController.h"


#define sdCycleScrollView_Height screen_width*0.6

static NSString *const kMainCollectionViewReuseIdentifier = @"kMainCollectionViewReuseIdentifier";
static NSString *const kReusableViewReuseIdentifier = @"kReusableViewReuseIdentifier";
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *imageURLStringsGroupArr;
@property (nonatomic,strong)NSMutableArray *titlesGroupArr;
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)SDCycleScrollView *sdCycleScrollView;
@property (nonatomic,strong)NSArray *hotLiveGroupArr;
@property (nonatomic,strong)NSArray *topAdGroupArr;
@end

@implementation HomeViewController
#pragma mark ----- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self layoutUI];
    //[NSThread sleepForTimeInterval:1.0f];
    self.imageURLStringsGroupArr = [[NSMutableArray alloc] init];
    self.titlesGroupArr = [[NSMutableArray alloc] init];
    self.hotLiveGroupArr = [[NSMutableArray alloc] init];
    self.topAdGroupArr = [[NSArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void)setupView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat flowLayout_Height = 0.0f;
    if (IS_IPHONE_4) {
        
        flowLayout_Height =  (screen_height-64-kTarBar_height-sdCycleScrollView_Height)/2;
    }
    else
    {
        flowLayout_Height =  (screen_height-64-kTarBar_height-sdCycleScrollView_Height)/3;
    }
    flowLayout.itemSize = CGSizeMake(screen_width/2,flowLayout_Height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //下面两句话不设置会出现排版偏移问题
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.headerReferenceSize = CGSizeMake(screen_width, sdCycleScrollView_Height);
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:kMainCollectionViewReuseIdentifier];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableViewReuseIdentifier];
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate = self;
    [self.view addSubview:self.mainCollectionView];
    __weak HomeViewController *weakSelf = self;
    _mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestData];
        
    }];
   
    [_mainCollectionView.mj_header beginRefreshing];
    
}
- (void)layoutUI {
    
    
    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);

    }];

}
#pragma mark-----Private method
- (void)requestData {
    //请求广告栏主播数据
    HomeTopParam *topParam = [HomeTopParam param];
    [HomeTopHttps requestDataWithHomeParam:topParam  HomeDataBlcok:^(NSArray *result, NSError *error) {
        
        [self.mainCollectionView.mj_header endRefreshing];
        if (result) {
            self.topAdGroupArr = result;
            [self.imageURLStringsGroupArr   removeAllObjects];
            [self.titlesGroupArr removeAllObjects];
            for(HomeTopData *data in result) {
                
                [self.imageURLStringsGroupArr addObject:[data.qcm_img clearURL]];
                [self.titlesGroupArr addObject:data.title];
            }
            self.sdCycleScrollView.imageURLStringsGroup = self.imageURLStringsGroupArr;
            self.sdCycleScrollView.titlesGroup = self.titlesGroupArr;
            //[self.mainCollectionView reloadData];
        }
        
    }];
    //请求热门主播数据
    HomeHotLiveParam *liveParam = [HomeHotLiveParam param];
    [HomeHotLiveHttps requestDataWithHomeParam:liveParam HomeDataBlcok:^(NSArray *result, NSError *error) {
        [self.mainCollectionView.mj_header endRefreshing];
        if (result) {
            
            self.hotLiveGroupArr = [NSArray arrayWithArray:result];
            [self.mainCollectionView reloadData];
        }
        
    }];
    self.sdCycleScrollView.imageURLStringsGroup = self.imageURLStringsGroupArr;
    self.sdCycleScrollView.titlesGroup = self.titlesGroupArr;
    
}

#pragma mark----UICollectionViewDataSource,UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kReusableViewReuseIdentifier forIndexPath:indexPath];
    self.sdCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(5, 5, screen_width-10, sdCycleScrollView_Height-5)];
    self.sdCycleScrollView.delegate = self;
    self.sdCycleScrollView.placeholderImage = [UIImage imageNamed:@"defaultlivebg"];
    self.sdCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.sdCycleScrollView.titleLabelTextColor = [UIColor whiteColor];
    self.sdCycleScrollView.imageURLStringsGroup = self.imageURLStringsGroupArr;
    self.sdCycleScrollView.titlesGroup = self.titlesGroupArr;
    [reusableView addSubview:self.sdCycleScrollView];
    return reusableView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCollectionViewReuseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[HomeCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    [cell updateUIFrame:indexPath];
    [cell updateUIWithHomeData:self.hotLiveGroupArr[indexPath.row]];
   
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.hotLiveGroupArr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeHotLiveData *data = [[HomeHotLiveData alloc] init];
    if (self.hotLiveGroupArr.count>=indexPath.row) {
        data = self.hotLiveGroupArr[indexPath.row];
    }
    [self presentLiveRoomViewControllerWithRoomid:data.roomid];
}
#pragma mark----SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    HomeTopData *data = [[HomeTopData alloc] init];
    if (self.topAdGroupArr.count>=index) {
        data = self.topAdGroupArr[index];
    }
    [self presentLiveRoomViewControllerWithRoomid:data.roomid];
}
#pragma mark----getting&&setting
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
