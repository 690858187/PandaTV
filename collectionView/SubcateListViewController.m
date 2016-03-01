//
//  LiveViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//


#import "SubcateListViewController.h"
#import "HomeCollectionViewCell.h"
#define sdCycleScrollView_Height screen_width*0.6
static NSString *const kMainCollectionViewReuseIdentifier = @"kMainCollectionViewReuseIdentifier";
@interface SubcateListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger pageno;
    NSInteger pagenum;
    NSInteger status;
    BOOL isRefershing;
    
}
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)NSMutableArray *liveGroupArr;
@property (nonatomic,strong)UIButton *leftBtn;
@end

@implementation SubcateListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    isRefershing = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.liveGroupArr = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
    [self layoutUI];
}
- (void)setupView {
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 30, 54);
    self.leftBtn.backgroundColor = [UIColor redColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"ico_return_normal"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationController.navigationItem.leftBarButtonItem = backBarButtonItem;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat flowLayout_Height = 0.0f;
    if (IS_IPHONE_4) {
        
        flowLayout_Height =  (screen_height-64-49-sdCycleScrollView_Height)/2;
    }
    else
    {
        flowLayout_Height =  (screen_height-64-49-sdCycleScrollView_Height)/3;
    }
    flowLayout.itemSize = CGSizeMake(screen_width/2,flowLayout_Height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //下面两句话不设置会出现排版偏移问题
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:kMainCollectionViewReuseIdentifier];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate = self;
    [self.view addSubview:self.mainCollectionView];
    __weak SubcateListViewController *weakSelf = self;
    _mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        isRefershing = YES;
        [weakSelf requestData];
        
    }];
    //_mainCollectionView.mj_footer.appearencePercentTriggerAutoRefresh = 0.8;
    _mainCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        isRefershing = NO;
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
    
    if (isRefershing) {
        pageno = 0;
        pagenum = 10;
        status = 2;
    }
    else
    {
        pageno = pageno+1;
        pagenum= 10;
        status = 2;
    }
    //    //请求热门主播数据
    LiveParam *liveParam = [LiveParam paramWithCate:self.cate Pageno:pageno Pagenum:pagenum status:status];
    [LiveHttps requestDataWithHomeParam:liveParam HomeDataBlcok:^(NSArray *result, NSError *error) {
        
        if (result) {
            
            if (isRefershing) {
                [self.mainCollectionView.mj_header endRefreshing];
                self.liveGroupArr = [NSMutableArray arrayWithArray:result];
            }
            else
            {
                [self.mainCollectionView.mj_footer endRefreshing];
                [self.liveGroupArr addObjectsFromArray:result];
                
                if (result.count<10) {
                    [self.mainCollectionView.mj_footer setState:MJRefreshStateNoMoreData];
                }
                
            }
            
            [self.mainCollectionView reloadData];
        }
        
    }];
    
}

- (void)leftBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark----UICollectionViewDataSource,UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCollectionViewReuseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[HomeCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    [cell updateUIFrame:indexPath];
    [cell updateUIWithLiveData:self.liveGroupArr[indexPath.row]];
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.liveGroupArr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveData *data = [[LiveData alloc] init];
    if (self.liveGroupArr.count>=indexPath.row) {
        data = self.liveGroupArr[indexPath.row];
    }
    [self presentLiveRoomViewControllerWithRoomid:data.id];
}
@end
