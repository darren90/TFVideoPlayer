//
//  TFVideoPlayerViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFMoviePlayerViewController.h"
//#import "DBTools.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"

@interface TFMoviePlayerViewController ()<AVAudioSessionDelegate,TFVideoPlayerDelegate>

@end

@implementation TFMoviePlayerViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
//    [self.player playerWillAppear];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
//    [self.player playerDidDisAppear];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //程序被强制关闭的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleInterruption:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
    //观看中接收到电话
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    [[AVAudioSession sharedInstance] setDelegate:self];
 
    self.playerView = [[TFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
    self.playerView.player.delegate = self;
    self.playerView.player.showState = TFVideoPlayerFull;
    
    [self.playerView playStream:self.playUrl];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
//    self.playerVc.player.showState = TFVideoPlayerCell;

    NSLog(@"%@", NSStringFromCGRect(parent.view.frame));
    NSLog(@"se: %@",NSStringFromCGRect(self.view.frame));
}

- (void)handleInterruption:(NSNotification *)notice{
    /* For example:
     [[NSNotificationCenter defaultCenter] addObserver: myObject
     selector:    @selector(handleInterruption:)
     name:        AVAudioSessionInterruptionNotification
     object:      [AVAudioSession sharedInstance]];
     */
    [self.playerView.player pauseContent];
    [self saveSeekDuration];
}

#pragma mark - 保存看剧时间
- (void)saveSeekDuration{
//    [DBTools saveSeekDuration:self.topTitle duration:self.player.currentDuraion];
}

- (void)setPlayUrl:(NSURL *)playUrl {
    _playUrl = playUrl;

//    self.playerView.player.showState = TFVideoPlayerFull;
    
    [self.playerView playStream:self.playUrl];
}

- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event{
    if (self.playerView.player.view.isLockBtnEnable) {
        return;
    }
    
    switch (event) {
        case TFVideoPlayerControlEventTapDone: {
            [self.playerView.player pauseContent];
            [self saveSeekDuration];
            [self dismissViewControllerAnimated:YES completion:^{
                [self unInstallPlayer];
            }];
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
    [[AVAudioSession sharedInstance] setDelegate:nil];
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.playerView.player.view.isLockBtnEnable) {
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            return  UIInterfaceOrientationMaskLandscapeRight;
        }else if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
            return UIInterfaceOrientationMaskLandscapeLeft;
        }
        return UIInterfaceOrientationMaskLandscape;
    }else{
        return UIInterfaceOrientationMaskLandscape;
    }
}

@end
