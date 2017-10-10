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
        self.playerView.player.showState = TFVideoPlayerSmall;
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    } else {
        //大屏
        self.playerView.player.showState = TFVideoPlayerFull;
        
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
//    NSLog(@"bgView--: %@", self.bgView.subviews);
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event{
    if (self.playerView.player.view.isLockBtnEnable) {
        return;
    }
    
    switch (event) {
        case TFVideoPlayerControlEventTapDone: {
            if (self.playerView.player.showState == TFVideoPlayerFull) {
                 [self fulllScrenAction];
                return;
            } else {
                [self.playerView.player pauseContent];
//                [self saveSeekDuration];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        case TFVideoPlayerControlEventPause: {
            [self.playerView.player pauseContent];
            
        }
            break;
            
        case TFVideoPlayerControlEventTapFullScreen: {
            [self fulllScrenAction];
        }
            break;
        default:
            break;
    }
}


- (void)fulllScrenAction {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (int)(UIInterfaceOrientation)orientation;

    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"fullScreenAction第3个旋转方向---电池栏在下");
//            self.isFullScreen = YES;
            self.playerView.player.showState = TFVideoPlayerFull;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"fullScreenAction第0个旋转方向---电池栏在上");
            self.playerView.player.showState = TFVideoPlayerSmall;
//            self.isFullScreen = YES;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"fullScreenAction第2个旋转方向---电池栏在右");
            self.playerView.player.showState = TFVideoPlayerFull;
//            self.isFullScreen = NO;
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"fullScreenAction第1个旋转方向---电池栏在左");
//            self.isFullScreen = NO;
            self.playerView.player.showState = TFVideoPlayerFull;
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationUnknown:{
            NSLog(@"fullScreenAction第1个旋转方向---电池栏在左");;
            self.playerView.player.showState = TFVideoPlayerSmall;
//            self.isFullScreen = YES;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:{
            self.playerView.player.showState = TFVideoPlayerFull;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
    }
    
    //    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
    //    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0];
}

#pragma mark 强制转屏相关
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        int val                  = orientation;
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
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
