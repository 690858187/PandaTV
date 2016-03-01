#import "LiveRoomViewController.h"
#import "CommonSelectView.h"
#import "HostDetailTableViewCell.h"
#import "LiveDetailTableViewCell.h"
#import "LiveTextDetailTableViewCell.h"
#import "chatInputView.h"   //聊天输入框
#import "AVPlayView.h"      //播放页面
#define URL @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"

#define PlayView_Height   screen_width*0.65 //播放页面高度
#define SelectView_Height 40                //选择控制器高度
#define ScrollView_Height screen_height-PlayView_Height-SelectView_Height-20 //主scrollView高度
#define InputView_Height  50                //输入框高度

static NSString *const  kHostDetailTableViewCellReuseIdentifier = @"kHostDetailTableViewCellReuseIdentifier";
static NSString *const  kLiveDetailTableViewCellReuseIdentifier = @"kLiveDetailTableViewCellReuseIdentifier";
static NSString *const  kLiveTextDetailTableViewCellReuseIdentifier = @"kLiveTextDetailTableViewCellReuseIdentifier";
@interface LiveRoomViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)AVPlayView *playView;
@property (nonatomic,strong)CommonSelectView *selectView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UITableView *liverDetailTableView;
@property (nonatomic,strong)UITableView *chatTableView;
@property (nonatomic,strong)LiveRoomData *roomData;
@property (nonatomic,strong)ChatInputView *inputView;
@property (nonatomic,assign)UIInterfaceOrientation status;
- (void)addChatAction;
@end
@implementation LiveRoomViewController

#pragma mark----addObserver

- (void)addObserver {
     //监听屏幕旋转状态
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotification) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
   
   
}

#pragma mark----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = UIInterfaceOrientationPortrait;
    [self setupView];
    [self layoutUI];
    [self addObserver];
    [self requestData];
}
- (void)setupView {
    
    self.playView = [AVPlayView new];
    self.playView.backgroundColor = kColor(100, 100, 100, 1);
    [self.view addSubview:self.playView];
    [self.playView play];
    
    self.selectView = [[CommonSelectView alloc] initWithFrame:CGRectZero TitleGroupArr:@[@"聊天",@"主播详情"]];
    __weak LiveRoomViewController *weakSelf = self;
    self.selectView.selectTypeBlcok = ^(NSInteger selectType){
        [weakSelf.view endEditing:YES];
        [weakSelf.mainScrollView setContentOffset:CGPointMake(screen_width*selectType, 0) animated:NO];
    };
    [self.view addSubview:self.selectView];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, PlayView_Height+SelectView_Height+20, screen_width,ScrollView_Height)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.backgroundColor = kTable_BackColor;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(screen_width*2, ScrollView_Height);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    for (int i=0; i<2; i++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(screen_width*i, 0, screen_width, ScrollView_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        [self.mainScrollView addSubview:tableView];
        switch (i) {
            case 0://聊天
            {
                self.chatTableView = tableView;
            }
                break;
            case 1://主播详情
            {
                
                self.liverDetailTableView = tableView;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [tableView registerClass:[HostDetailTableViewCell class] forCellReuseIdentifier:kHostDetailTableViewCellReuseIdentifier];
                [tableView registerClass:[LiveDetailTableViewCell class] forCellReuseIdentifier:kLiveDetailTableViewCellReuseIdentifier];
                [tableView registerClass:[LiveTextDetailTableViewCell class] forCellReuseIdentifier:kLiveTextDetailTableViewCellReuseIdentifier];
            }
                break;

                
            default:
                break;
        }
        
    }
    
    self.inputView = [[ChatInputView alloc] initWithFrame:CGRectMake(0, self.mainScrollView.height-InputView_Height, screen_width, InputView_Height)];
    self.inputView.addChatBlock = ^(){
    };
    [self.mainScrollView addSubview:self.inputView];

}

- (void)layoutUI {
    
    if (self.status == UIInterfaceOrientationPortrait) {
        
        [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(20);
            make.height.equalTo(@(PlayView_Height));
        }];
        
        [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(SelectView_Height));
            make.top.equalTo(self.playView.mas_bottom);
        }];
    }
    else {
        
        [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(20);
        }];
        
    }
    
   

}

#pragma mark-----UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView ==self.chatTableView) {
        
        return nil;
    }
    else {
       
        switch (indexPath.row) {
            case 0:
            {
                 HostDetailTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:kHostDetailTableViewCellReuseIdentifier forIndexPath:indexPath];
                [cell updateUIWith:self.roomData];
                return cell;
            }
                break;
            case 1:
            {
                LiveTextDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveTextDetailTableViewCellReuseIdentifier forIndexPath:indexPath];
                [cell updateUIWithTextStr:self.roomData.info.roominfo.bulletin];
                
                return cell;
            }
                break;
                
            default:
                break;
        }
        
    }
    return nil;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView ==self.chatTableView) {
        
        return 0;
    }
    else {
        return 2;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView ==self.chatTableView) {
        
        return 0;
    }
    else {
        switch (indexPath.row) {
            case 0:
            {
                return 100;
            }
                break;
            case 1:
            {
                return 200;
            }
                break;
            default:
                break;
        }
        
       
    }
    return 0;
}
#pragma mark-----Private Method
- (void)requestData {
    
    LiveRoomParams *params = [LiveRoomParams paramsWithRoomid:self.roomid];
    [LiveRoomHttps requestDataWithLiveRoomParam:params HomeDataBlcok:^(LiveRoomData *result, NSError *error) {
        
        if (!error) {
            self.roomData = result;
            self.playView.shareURLStr = result.info.roominfo.id;
            [self.liverDetailTableView reloadData];
        }else {
            
            
        }
        
    }];
}

- (void)addChatAction {
    
}

/**
 *  监听屏幕旋转状态改变
 *
 *  @param notification notification
 */

- (void)deviceOrientationDidChangeNotification {
    
    UIInterfaceOrientation status=[UIApplication sharedApplication].statusBarOrientation;
    [self preferredInterfaceOrientationForPresentation];
    self.status = status;
    [self layoutUI];
    switch (status) {
        case UIInterfaceOrientationUnknown:             //未知
            
            break;
        case UIInterfaceOrientationPortrait:            //正常
            
            break;

        case UIInterfaceOrientationPortraitUpsideDown:  //上下颠倒
            
            break;

        case UIInterfaceOrientationLandscapeLeft:       //左
            
            break;

        case UIInterfaceOrientationLandscapeRight:      //右
            
            break;

            
        default:
            break;
    }
    
}


#pragma mark-----SuperMethod(重写)

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //判断屏幕旋转状态
    UIInterfaceOrientation status=[UIApplication sharedApplication].statusBarOrientation;
    switch (status) {
        case UIInterfaceOrientationUnknown:             //未知
        {
            
        }
            break;
        case UIInterfaceOrientationPortrait:            //正常
        {
            
        }
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:  //上下颠倒
        {
            
        }
            break;
            
        case UIInterfaceOrientationLandscapeLeft:       //左
        {
            return status;
        }
            break;
            
        case UIInterfaceOrientationLandscapeRight:      //右
        {
             return status;
        }
            break;
            
            
        default:
            break;
    }
    return UIInterfaceOrientationPortrait;
    
}

//-(NSUInteger )supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeRight;
//}

@end
