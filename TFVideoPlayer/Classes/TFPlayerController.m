//
//  TFPlayerController.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFPlayerController.h"
#import "TFPlayer.h"

@interface TFPlayerController()<TFVideoPlayerDelegate >

@end

@implementation TFPlayerController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.player playerWillAppear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.player playerDidDisAppear];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.player = [[TFVideoPlayer alloc]init];
    self.player.view.frame = self.view.bounds;
    self.player.delegate = self;
    [self.view addSubview:self.player.view];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
//    [self.player playStreamUrl:[NSURL fileURLWithPath:urlStr]];

    NSURL *urlS = [NSURL fileURLWithPath:urlStr];
    NSURL *url = [NSURL URLWithString:@"http://cn-hbjz7-dx.acgvideo.com/vg6/8/cc/3962208.mp4?expires=1466061600&ssig=i27qqMZENDnovBmHAwl5sQ&oi=2095617680&player=1&or=3662449045&rate=0"];
    //        url = [NSURL URLWithString:@"http://cn-hbjz1-dx.acgvideo.com/vg10/a/65/3905663.mp4?expires=1465818000&ssig=3vivDNjBQFXq6w5HfSnExw&oi=2095617680&player=1&or=3662449045&rate=0"];
//    url = [NSURL URLWithString:@"http://k.youku.com/player/getFlvPath/sid/746605444635887514583_00/st/mp4/fileid/03002001005726299AAEC02D9B7D2FBB58F8AA-A8AD-FCF0-0FB5-6842F4C6C997?K=b0a8f6edc52c48902412a450&hd=1&ts=2579&oip=2014991661&sid=746605444635887514583&token=2833&did=2cc3249c13847a089a3a8f015fcd2e88&ev=1&ctype=87&ep=SB65QBab70Mkl7QjNhwNcLIYMXARjEjaJBgkwXCa37QwFMDG62pU3Y0zDQhBcgdk8Dphp3hZhEcDxnLpsyJZURxlYBrf2vjBXzdj1fTp44c4ynsbE%2BbCov%2BaGq8x9XPO"];
//    url = [NSURL URLWithString:@"http://cn-hbjz6-dx.acgvideo.com/vg7/8/66/4189690-1.flv?expires=1466063100&ssig=khOfeV4VHEONPLl7HtMuoA&oi=2095617680&player=1&or=3662449045&rate=0"];
//    url= [NSURL URLWithString:@"http://k.youku.com/player/getFlvPath/sid/946604469680387a1b4b7_00/st/mp4/fileid/0300200100564F3F3214112D9B7D2F998C44A0-42F7-FB24-5537-E13010499D01?K=c1cd1ad9817f66612412a447&hd=1&ts=2583&oip=2014991661&sid=946604469680387a1b4b7&token=2791&did=4ce9ac5cb32dccf546b6391727cb7b99&ev=1&ctype=87&ep=wwB8Y6M%2F1DfMdyEWyl7nUlrO3hJTNkym04BnFRrZ3ZK55KLYf9vxBD7tdz8GDFTIJQTX4KkmKzLkpQscpd7q%2BGFQmLeO1jetOoM9j2ij07XJ5juxJYuZXgC94MnqIW0T"];
    if (self.playUrl) {
//        self.playUrl = url;
        [self playStream:self.playUrl];
    }else{
        [self playStream:url];
    }
//    [self.player playStreamUrl:self.playUrl];
}

/**
 *  小屏播放器要用到
 *
 *  @param url 播放地址
 */
//- (void)playStream:(NSURL*)url {
//    [self.player playStreamUrl:url title:@"水电费水电费水电费" seekToPos:300];
//}

-(void)playStream:(NSURL *)url
{
    [self.player playChangeStreamUrl:url title:@"sdfsdfself.playUrlsd" seekToPos:100];
}


- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event
{
    if (self.player.view.isLockBtnEnable) {
        return;
    }
    
    switch (event) {
        case TFVideoPlayerControlEventTapDone:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [self unInstallPlayer];
            }];
        }
            break;
            
        default:
            break;
    }
    
    
}


-(void)dealloc {
    [self unInstallPlayer];
}

#pragma mark - 卸载播放器
-(void)unInstallPlayer
{
    [_player pauseContent];
    [_player unInstallPlayer];
    _player.delegate = nil;
    [_player.view removeFromSuperview];
    _player.view = nil;
    _player = nil;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.player.view.isLockBtnEnable) {
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
