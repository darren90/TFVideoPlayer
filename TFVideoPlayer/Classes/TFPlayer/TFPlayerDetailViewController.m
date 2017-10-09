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
//    [self.playerView playStream:self.playUrl];
}

- (void)initiaize {
    self.bgView = [[UIView alloc] init];
    [self.view addSubview:self.bgView];
//    self.bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 9 / 16.0);
    self.bgView.backgroundColor = [UIColor brownColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.view);
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

- (void)viewDidLayoutSubviews {
    NSLog(@"final-bg-frmae: %@", NSStringFromCGRect(self.bgView.frame));
}

-(void)viewWillLayoutSubviews{
    NSLog(@"final-bg-frmae: %@", NSStringFromCGRect(self.bgView.frame));

    
}


//这个方法发生在翻转的过程中，一般用来定制翻转后各个控件的位置、大小等
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    UIInterfaceOrientation interfaceOrientation = (int)(UIInterfaceOrientation)orientation;
    
    [self.playerView removeFromSuperview];

    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.removeExisting = YES;
    }];

    if (toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationUnknown) {
        //小屏幕
        [self.bgView addSubview:self.playerView];
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
            
        case TFVideoPlayerControlEventTapFullScreen: {
            
            
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
