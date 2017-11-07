//
//  TFVideoPlayer.m
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFVideoPlayerView.h"
#import "Vitamio.h"

typedef enum {
    TFVideoPlayerStateUnknown,
    TFVideoPlayerStateContentLoading,
    TFVideoPlayerStateContentPlaying,
    TFVideoPlayerStateContentPaused,
    TFVideoPlayerStateSuspend,
    TFVideoPlayerStateDismissed,
    TFVideoPlayerStateError
} TFVideoPlayerState;

typedef enum {
    TFVideoPlayerControlEventTapPlayerView,
    TFVideoPlayerControlEventTapNext,
    TFVideoPlayerControlEventTapPrevious,
    TFVideoPlayerControlEventTapDone,
    TFVideoPlayerControlEventTapFullScreen,
    TFVideoPlayerControlEventTapCaption,
    TFVideoPlayerControlEventTapVideoQuality,
    TFVideoPlayerControlEventSwipeNext,
    TFVideoPlayerControlEventSwipePrevious,
    TFVideoPlayerControlEventShare,//分享
    TFVideoPlayerControlEventPause,//暂停
    TFVideoPlayerControlEventPlay,//播放
} TFVideoPlayerControlEvent;


@class TFVideoPlayer;
@protocol TFVideoPlayerDelegate <NSObject>

@optional
- (BOOL)shouldVideoPlayer:(TFVideoPlayer*)videoPlayer changeStateTo:(TFVideoPlayerState)toState;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer willChangeStateTo:(TFVideoPlayerState)toState;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didChangeStateFrom:(TFVideoPlayerState)fromState;

- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didChangeSubtitleFrom:(NSString*)fronLang to:(NSString*)toLang;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer willChangeOrientationTo:(UIInterfaceOrientation)orientation;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation;

@end


@protocol TFVideoPlayermDelegate <NSObject>

- (void)fulllScrenAction;

@end

@interface TFVideoPlayer : NSObject<VMediaPlayerDelegate>

@property (nonatomic, strong) TFVideoPlayerView *view;

@property (nonatomic, strong) VMediaPlayer       *mMPayer;

@property (nonatomic, weak) id<TFVideoPlayerDelegate> delegate;

@property (nonatomic,copy) NSString * playUrl;

/***  视频当前播放到那个时间 单位：秒s */
@property (nonatomic,assign)double currentDuation;

/***  视频总时间 单位：秒s */
@property (nonatomic,assign)double totalDuraion;

@property (nonatomic, assign) TFVideoPlayerShowState showState;


/** 单例的方式创建播放器 */
+ (TFVideoPlayer *) sharedPlayer;

//正在播放的过程中切换了播放地址，进行播放的时候用这个  时间：秒
-(void)playChangeStreamUrl:(NSURL *)url title:(NSString *)title seekToPos:(long)pos;

-(void)playStreamUrls:(NSArray *)urls title:(NSString *)title seekToPos:(long)pos;


/** 播放 */
- (void)playContent;
/** 暂停 */
- (void)pauseContent;

#pragma mark - 卸载播放器
-(void)unInstallPlayer;


@property (nonatomic, weak) id<TFVideoPlayermDelegate> mDelegate;


//小屏幕播放
//@property (nonatomic,assign)BOOL isSmallPlay;//kvc 用的
//@property (nonatomic, assign) BOOL isFullScreen;


//当前播放到第几秒
//@property (nonatomic,assign) double currentDuraion;
//@property (nonatomic, assign) UIInterfaceOrientation visibleInterfaceOrientation;
//@property (nonatomic, assign) CGRect landscapeFrame;
//@property (nonatomic, assign) CGRect portraitFrame;
//@property (nonatomic, assign) BOOL forceRotate;
-(void)playerWillAppear;
-(void)playerDidDisAppear;


@end










