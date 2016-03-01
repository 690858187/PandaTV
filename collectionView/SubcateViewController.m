//
//  SubcateViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SubcateViewController.h"
#import "SubcateCollectionViewCell.h"
#import "SubcateListViewController.h"
#define flowLayout_Height screen_width/2
static NSString *const kSubcateCollectionViewCellReuseIdentifier = @"kSubcateCollectionViewCellReuseIdentifier";
@interface SubcateViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)NSMutableArray *subcateGroupArr;
@property (nonatomic,strong)UIButton *leftBtn;
@end

@implementation SubcateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.subcateGroupArr = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
    [self layoutUI];
    
}

- (void)setupView {
    
//    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.leftBtn.frame = CGRectMake(0, 0, 30, 54);
//    self.leftBtn.backgroundColor = [UIColor redColor];
//    [self.leftBtn setImage:[UIImage imageNamed:@"ico_return_normal"] forState:UIControlStateNormal];
//    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//     UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
//    self.navigationController.navigationItem.leftBarButtonItem = backBarButtonItem;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(screen_width/3,flowLayout_Height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //下面两句话不设置会出现排版偏移问题
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_mainCollectionView registerClass:[SubcateCollectionViewCell class] forCellWithReuseIdentifier:kSubcateCollectionViewCellReuseIdentifier];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate = self;
    [self.view addSubview:self.mainCollectionView];
    __weak SubcateViewController *weakSelf = self;
    _mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestData];
        
    }];
    MJRefreshAutoFooter *footer  =[[MJRefreshAutoFooter alloc] init];
    footer.triggerAutomaticallyRefreshPercent = 0.8;
    _mainCollectionView.mj_footer = footer;
    [_mainCollectionView.mj_header beginRefreshing];
    
}

- (void)layoutUI {

    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view);
    }];
    
}

#pragma mark-----Private method

- (void)requestData {
    
    SubcateParam *param = [SubcateParam param];
    
    [SubcateHttps requestDataWithHomeParam:param HomeDataBlcok:^(NSArray *result, NSError *error) {
        if (result) {
            
            self.subcateGroupArr = [result mutableCopy];
            [self.mainCollectionView reloadData];
        }
        [self.mainCollectionView.mj_header endRefreshing];
    }];
    
}

- (void)leftBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-----UICollectionViewDataSource,UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SubcateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSubcateCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[SubcateCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    //cell.backgroundColor = [UIColor redColor];
    [cell updateUIFrame:indexPath];
    [cell updateUIWith:self.subcateGroupArr[indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.subcateGroupArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SubcateData *date = [[SubcateData alloc] init];
    if (self.subcateGroupArr.count>=indexPath.row+1) {
      
        date = self.subcateGroupArr[indexPath.row];
        
    }
    SubcateListViewController *vc = [[SubcateListViewController alloc] init];
    vc.cate = date.ename;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.image = [UIImage imageNamed:@"user"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"user_pressed"];
    nav.navigationBar.barTintColor = kBackColor_tone;

    [nav.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航栏背景图片
    [[UINavigationBar appearance] setBackgroundImage:[Common imageWithColor:kBackColor_tone size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部黑线
    [nav.navigationBar setBackgroundImage:[Common imageWithColor:kBackColor_tone size:CGSizeMake(1, 1)]
                                forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 54);
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setImage:[UIImage imageNamed:@"ico_return_normal"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    nav.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
