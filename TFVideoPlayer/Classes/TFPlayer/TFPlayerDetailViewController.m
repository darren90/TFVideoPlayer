//
//  TFPlayerDetailViewController.m
//  Pods
//
//  Created by Fengtf on 2017/10/8.
//

#import "TFPlayerDetailViewController.h"
#import "TFPlayerView.h"
#import "Masonry.h"

@interface TFPlayerDetailViewController ()<TFVideoPlayerDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) TFPlayerView *playerView;
//@property (nonatomic, strong) UIView *redView;

@end

@implementation TFPlayerDetailViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initiaize];

    self.view.backgroundColor = [UIColor whiteColor];
    self.playerView.playUrl = self.playUrl;
//    [self.playerView playerOnCellView:self.bgView];
    [self.playerView playStream:self.playUrl];
}

- (void)initiaize {
    self.bgView = [[UIView alloc] init];
    [self.view addSubview:self.bgView];
//    self.bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 9 / 16.0);
    self.bgView.backgroundColor = [UIColor brownColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(@0);
        make.width.mas_equalTo(@(self.view.frame.size.width));
        make.height.mas_equalTo(@(self.view.frame.size.width * 9 / 16.0));
    }];
    
    self.playerView = [[TFPlayerView alloc] init];
    self.playerView.player.delegate = self;
    [self.bgView addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_offset(UIEdgeInsetsZero);
     }];
    
//    self.redView = [[UIView alloc] init];
//    [self.bgView addSubview:self.redView];
//    self.redView.backgroundColor = [UIColor redColor];
//    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.edges.mas_offset(UIEdgeInsetsZero);
//     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (int)(UIInterfaceOrientation)orientation;
    
    [self.playerView removeFromSuperview];
    
    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.removeExisting = YES;
    }];
    
    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationUnknown) {
        //小屏幕
        [self.playerView addSubview:self.playerView];
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    } else {
        //大屏
        [[UIApplication sharedApplication].keyWindow addSubview:self.playerView];
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.equalTo(@0);
            make.width.equalTo(@([[UIScreen mainScreen] bounds].size.height));
            make.height.equalTo(@([[UIScreen mainScreen] bounds].size.width));
            make.center.equalTo([UIApplication sharedApplication].keyWindow);
        }];
    }
    
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == interfaceOrientation) { return; }
    
    //    [self fulllScrenAction];
    
    // iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    // 也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:NO];
    // 获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    // 给你的播放视频的view视图设置旋转
    self.view.transform = CGAffineTransformIdentity;
    self.view.transform = [self getTransformRotationAngle];
    // 开始旋转
    [UIView commitAnimations];
}

/**
 * 获取变换的旋转角度
 *
 * @return 角度
 */
- (CGAffineTransform)getTransformRotationAngle {
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}


//这个方法发生在翻转的过程中，一般用来定制翻转后各个控件的位置、大小等。
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"bgView--: %@", self.bgView.subviews);
}
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    NSLog(@"bgView--: %@", self.bgView.subviews);
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    UIInterfaceOrientation interfaceOrientation = (int)(UIInterfaceOrientation)orientation;
//
//    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationUnknown) {
//        //小屏幕
//        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_offset(UIEdgeInsetsZero);
//        }];
//        [self.bgView layoutIfNeeded];
//    } else {
//        //大屏
//        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.leading.top.trailing.equalTo(@0);
//            make.width.equalTo(@([[UIScreen mainScreen] bounds].size.height));
//            make.height.equalTo(@([[UIScreen mainScreen] bounds].size.width));
//            make.center.equalTo([UIApplication sharedApplication].keyWindow);
//        }];
//
//        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
//    }
//}

- (BOOL)shouldAutorotate{
    return YES;
}

- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event{
    if (self.playerView.player.view.isLockBtnEnable) {
        return;
    }
    
    switch (event) {
        case TFVideoPlayerControlEventTapDone: {
            [self.playerView.player pauseContent];
//            [self saveSeekDuration];
//            [self dismissViewControllerAnimated:YES completion:^{
//                [self unInstallPlayer];
//            }];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case TFVideoPlayerControlEventPause: {
            [self.playerView.player pauseContent];
            
        }
            break;
        default:
            break;
    }
    
    
}


-(void)dealloc{
    [self unInstallPlayer];
}

#pragma mark - 卸载播放器
-(void)unInstallPlayer {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerView.player pauseContent];
    [_playerView.player unInstallPlayer];
    _playerView.player.delegate = nil;
    [_playerView.player.view removeFromSuperview];
    _playerView.player.view = nil;
    _playerView.player = nil;
    
    [_playerView removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    NSLog(@"---TFMoviePlayerViewController--销毁了");
}

@end
