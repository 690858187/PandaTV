//
//  SearchViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBarView.h"
#import "CommonSelectView.h"
#import "HomeCollectionViewCell.h"
#import "SearchTableViewCell.h"
#import "SearchHistoryModel.h"
#define sdCycleScrollView_Height screen_width*0.6
#define CELL_TAG    10000
static NSString *const kMainCollectionViewReuseIdentifier = @"kMainCollectionViewReuseIdentifier";
static NSString *const kSearchTableViewCellReuseIdentifier = @"kSearchTableViewCellReuseIdentifier";
@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,SearchTableViewCellDelegate>
{
    /** 搜索状态：2：正在直播 3：未直播*/
    NSInteger Status;
    NSInteger livepageno;
    NSInteger livepagenum;
    NSInteger noLivepageno;
    NSInteger noLivepagenum;
    BOOL isLiveRefersh;
    BOOL isNoLiveRefersh;
    CGPoint oldPoint;
}
@property (nonatomic,strong)SearchBarView *barView;
@property (nonatomic,strong)CommonSelectView *selectView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UICollectionView *mainLiveCollectionView;
@property (nonatomic,strong)UICollectionView *mainNoLiveCollectionView;
@property (nonatomic,strong)NSMutableArray *liveGroupArr;
@property (nonatomic,strong)NSMutableArray *noLiveGroupArr;
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *searchHistoryGroupArr;
- (void)back;
- (void)search;
- (void)clearSearch;
@end

@implementation SearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    Status = 2;
    livepageno  = 1;
    livepagenum = 10;
    noLivepageno  = 1;
    noLivepagenum = 10;
    isLiveRefersh = YES;
    isNoLiveRefersh = YES;
    
    self.liveGroupArr = [[NSMutableArray alloc] init];
    self.noLiveGroupArr = [[NSMutableArray alloc] init];
    self.searchHistoryGroupArr = [[NSMutableArray alloc] init];
    [self setupView];
    [self layoutUI];
    [self loadSearchHistory];
}
- (void)setupView {
    
    self.barView  = [[SearchBarView alloc] init];
    __block SearchViewController *weakSelf = self;
    self.barView.backBlock  = ^(){[weakSelf back];};
    self.barView.searchBlock = ^(){[weakSelf search];};
    self.barView.searchClearBlock = ^(){[weakSelf loadSearchHistory];};
    [self.view addSubview:self.barView];
    
    self.selectView = [[CommonSelectView alloc] initWithFrame:CGRectZero TitleGroupArr:@[@"正在直播",@"还未直播"]];
    self.selectView.selectTypeBlcok = ^(NSInteger selectType){
        
        Status = selectType +2;
        [weakSelf.mainScrollView setContentOffset:CGPointMake(screen_width*selectType, 0) animated:NO];
        
    };
    [self.view addSubview:self.selectView];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.delegate = self;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.contentSize = CGSizeMake(screen_width*2, screen_height-kNavBar_height-40);
    [self.view addSubview:self.mainScrollView];
    for (int i=0; i<2; i++) {
        
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
        
        UICollectionView * collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(screen_width*i, 0, screen_width, screen_height-40-kTarBar_height) collectionViewLayout:flowLayout];
        [collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:kMainCollectionViewReuseIdentifier];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.mainScrollView addSubview:collectionView];
        switch (i) { //正在直播
            case 0:
                self.mainLiveCollectionView = collectionView;
                break;
            case 1: //还未直播
                self.mainNoLiveCollectionView = collectionView;
                break;
                
                
            default:
                break;
        }
        

    }
    _mainLiveCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        isLiveRefersh = YES;
        [weakSelf requestWithLiveData];
    }];
    _mainNoLiveCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        isNoLiveRefersh = YES;
        [weakSelf requestWithNoLiveData];
    }];
    
    _mainLiveCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        isLiveRefersh = NO;
        [weakSelf requestWithLiveData];
    }];
    _mainNoLiveCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
         isLiveRefersh = NO;
        [weakSelf requestWithNoLiveData];
    }];

    self.mainTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBar_height, screen_width, screen_height-kNavBar_height)];
    self.mainTable.dataSource = self;
    self.mainTable.delegate = self;
    [self.mainTable registerClass:[SearchTableViewCell class] forCellReuseIdentifier:kSearchTableViewCellReuseIdentifier];
    [self.view addSubview:self.mainTable];
    /** 清除tableview尾部空白 */
    [Common clearTableFootView:self.mainTable];
    
    
    
}
- (void)layoutUI {
    
    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kNavBar_height));
    }];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
        make.top.equalTo(self.barView.mas_bottom);
    }];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.selectView.mas_bottom);
    }];
    
}
#pragma mark----UICollectionViewDataSource,UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCollectionViewReuseIdentifier forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[HomeCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        [cell updateUIFrame:indexPath];
        if (collectionView==_mainLiveCollectionView) {
            
            [cell updateUIWithSearchLiveData:self.liveGroupArr[indexPath.row]];
        }
        else
        {
            [cell updateUIWithSearchLiveData:self.noLiveGroupArr[indexPath.row]];
            
        }
    
        return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView==self.mainLiveCollectionView) {
        
        return self.liveGroupArr.count;
    }
    else
    {
        return self.noLiveGroupArr.count;
    }
   
}
#pragma mark-----UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchTableViewCellReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:kSearchTableViewCellReuseIdentifier];
    }
    cell.delegate = self;
    cell.tag = CELL_TAG + indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       if (indexPath.row==0) {
        cell.backgroundColor = kColor(234, 234, 234, 1);
        cell.title = @"搜索历史";
        cell.img = [UIImage imageNamed:@"all_del_ico"];
        cell.titleLable.font = [UIFont systemFontOfSize:15];
        cell.imgSize = CGSizeMake(20, 20);
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        SearchHistoryModel *model = self.searchHistoryGroupArr[indexPath.row-1];
        cell.title = model.history;
        cell.img = [UIImage imageNamed:@"del_ico"];
        cell.titleLable.font = [UIFont systemFontOfSize:14];
        cell.imgSize = CGSizeMake(13, 13);
    }
    __weak SearchViewController *weakSelf = self;
    cell.clearBlock = ^(SearchTableViewCell *cell){
        NSLog(@"==%ld",(long)cell.tag);
        if (cell.tag==CELL_TAG) {
            [weakSelf clearSearch];
        }
        else {
            [weakSelf clearSearchWithHistory:cell.titleLable.text];
        }
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchHistoryGroupArr.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        return;
    }
    
    if (self.searchHistoryGroupArr.count>=indexPath.row-1) {
        
        SearchHistoryModel *model = self.searchHistoryGroupArr [indexPath.row-1];
        self.barView.searchBar.text =  model.history;
        self.barView.searchBlock(self.barView.searchBar.text);

    }
    
}

#pragma mark-----SearchTableViewCellDelegate

- (void)tableViewDeleteWithSearchTableViewCell:(SearchTableViewCell *)cell {
    
    SearchHistoryModel *model = [[SearchHistoryModel alloc] init];
    model.history = cell.titleLable.text;
    
}

#pragma mark-----Private Method
- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  点击搜索按钮
 */
- (void)search {
    [self.view endEditing:YES];
    [self loadSearchHistory];
    self.mainTable.hidden = YES;
    SearchHistoryModel *model = [[SearchHistoryModel alloc] init];
    model.history = self.barView.searchBar.text;
    if (StringHasValue(model.history)) {
        
        if (self.searchHistoryGroupArr.count==0) {
            [model save];
        }
        else {
            
            for (SearchHistoryModel *cacheModel in self.searchHistoryGroupArr) {
            
            if (![cacheModel.history isEqualToString:model.history]) {
                [model save];
                break;
            }
            }
        }
    }
    [self.mainLiveCollectionView.mj_header beginRefreshing];
    [self.mainNoLiveCollectionView.mj_header beginRefreshing];
}
/**
 * 清除表中所有搜索历史
 */
- (void)clearSearch {
    self.mainTable.hidden = NO;
    self.noLiveGroupArr = nil;
    self.liveGroupArr = nil;
    [self.mainLiveCollectionView reloadData];
    [self.mainNoLiveCollectionView reloadData];
    [SearchHistoryModel clearTable];
    [self loadSearchHistory];
    
}
/**
 *  根据条件删除搜索历史
 *
 *  @param history 查询删除的搜索历史
 */
- (void)clearSearchWithHistory:(NSString *)history
{
    BOOL isDelete = [SearchHistoryModel deleteObjectsByCriteria:[NSString stringWithFormat:@"where history=%@",history]];
    if (isDelete) {
        
        [self loadSearchHistory];
    }
   
    
}
/**
 *  加载表中搜索历史
 */
- (void)loadSearchHistory {
    self.searchHistoryGroupArr = [NSMutableArray arrayWithArray:[SearchHistoryModel findAll]];
    if (self.searchHistoryGroupArr.count==0) {
        self.mainTable.hidden = YES;
    }
    else {
        self.mainTable.hidden = NO;
        [self.mainTable reloadData];
    }
}
- (void)requestWithLiveData {

    Status = 2;
    
    if (isLiveRefersh) {
        
        livepageno  = 1;
        livepagenum = 10;

    }
    else {
        livepageno ++;
        livepagenum = 10;
    }
    
    SearchParams  *param = [SearchParams paramsWithKeyword:self.barView.searchBar.text Status:Status Pageno:livepageno Pagenum:livepagenum];
    [SearchHttps requestDataWithSearchParam:param HomeDataBlcok:^(NSArray *result, NSError *error) {
        [self.mainLiveCollectionView.mj_header endRefreshing];
            if (!error) {
            
            if (isLiveRefersh) {
                
                
                self.liveGroupArr = [NSMutableArray arrayWithArray:result];
                
            }else {
                
               
                if (result.count<10) {
                    [self.mainLiveCollectionView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.liveGroupArr addObjectsFromArray:result];
                
            }
            self.mainTable.hidden = YES;
            [self.mainLiveCollectionView reloadData];
            NSLog(@"------%@",NSStringFromCGRect(self.mainLiveCollectionView.frame));
           NSLog(@"------%@",NSStringFromCGRect(self.mainNoLiveCollectionView.frame));
            
        }
        else {
            
            
        }

        
    }];
    
}
- (void)requestWithNoLiveData {
    
    Status = 3;
    if (isNoLiveRefersh) {
        
        noLivepageno  = 1;
        noLivepagenum = 10;
        
    }
    else {
        noLivepageno ++;
        noLivepagenum = 10;
    }

    SearchParams  *param = [SearchParams paramsWithKeyword:self.barView.searchBar.text Status:Status Pageno:noLivepageno Pagenum:noLivepagenum];
    [SearchHttps requestDataWithSearchParam:param HomeDataBlcok:^(NSArray *result, NSError *error) {
        [self.mainNoLiveCollectionView.mj_header endRefreshing];
        if (!error) {
            
            if (isNoLiveRefersh) {
                self.noLiveGroupArr = [NSMutableArray arrayWithArray:result];
                
            }else {
                if (result.count<10) {
                    [self.mainScrollView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.noLiveGroupArr addObjectsFromArray:result];
                
            }
             [self.mainNoLiveCollectionView reloadData];
        }
        else {
            
            
        }
       
        
    }];
}
@end
