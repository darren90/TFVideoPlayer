//
//  TFVideoPlayerView.h
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TFVSegmentSlider.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ForwardBackView.h"


@protocol TFVideoPlayerViewDelegate <NSObject>

@property (nonatomic, readonly) UIInterfaceOrientation visibleInterfaceOrientation;

- (void)playButtonPressed;
- (void)pauseButtonPressed;
 
- (void)doneButtonTapped;

- (void)playerViewSingleTapped;


-(void)switchVideoViewModeButtonAction;

#pragma mark - 右上和右下的几个按钮被点击

- (void)shareButtonTapped;//点击分享按钮

//进度条相关

-(void)progressSliderUp:(float)value;

//得到当前的播放时间
-(long)getCurrentDuration;

//得到总的的播放时间
-(long)getTotalDuration;

-(void)progressSliderTapped:(CGFloat)percentage;
-(void)progressSliderDownAction;

//快进快推
-(void)endFastWithTime:(long)time;

//切换音轨
-(void)changeTrackTapped;

@end

#pragma mark - TFVideoPlayerView

@interface TFVideoPlayerView : UIView
/** 初始化播放控件 */
+(instancetype)videoPlayerView;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *singleGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleGesture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;
@property (nonatomic, strong) IBOutlet UIButton* doneButton;
/** 播放暂定按钮 */
@property (nonatomic, weak) IBOutlet UIButton *startPause;
@property (nonatomic, strong) IBOutlet UIButton* bigPlayButton;

@property (nonatomic, weak) IBOutlet UIButton *prevBtn;
@property (nonatomic, weak) IBOutlet UIButton *nextBtn;
@property (nonatomic, weak) IBOutlet UIButton *modeBtn;
@property (nonatomic, weak) IBOutlet UIButton *reset;
@property (nonatomic, weak) IBOutlet TFVSegmentSlider *progressSld;
@property (nonatomic, weak) IBOutlet UILabel  *curPosLbl;
@property (nonatomic, weak) IBOutlet UILabel  *durationLbl;
@property (nonatomic, weak) IBOutlet UILabel  *bubbleMsgLbl;//
@property (nonatomic, weak) IBOutlet UILabel  *downloadRate;//下载速度显示

@property (nonatomic, weak) IBOutlet UIView  	*activityCarrier;
@property (nonatomic, weak) IBOutlet UIView  	*backView;
@property (nonatomic, weak) IBOutlet UIView  	*carrier;
@property (nonatomic, weak) IBOutlet UIView  	*loadbgView;//加载的背景view

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;//分享

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;//选集
@property (weak, nonatomic) IBOutlet UIButton *smallLockBtn;//小锁屏

@property (nonatomic, weak) IBOutlet UIButton* fullscreenButton;

@property (nonatomic, copy)   NSURL *videoURL;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (weak, nonatomic) IBOutlet UIView *topControl;
@property (weak, nonatomic) IBOutlet UIView *bottomControl;
@property (weak, nonatomic) IBOutlet UIButton *trackBtn;

-(IBAction)goBackButtonAction:(id)sender;

#pragma mark - 切换音轨
- (IBAction)changeTrack:(UIButton *)sender;

#pragma mark - 开始 暂停
-(IBAction)startPauseButtonAction:(UIButton *)sender;


#pragma mark - 切换Model
-(IBAction)switchVideoViewModeButtonAction:(id)sender;
#pragma mark - reset
-(IBAction)resetButtonAction:(id)sender;

#pragma mark - 进度条相关
-(IBAction)progressSliderDownAction:(id)sender;
-(IBAction)progressSliderUpAction:(id)sender;
-(IBAction)dragProgressSliderAction:(id)sender;

#pragma mark - 手势
- (IBAction)handleSingleTap:(id)sender;
- (IBAction)handleTwoTap:(id)sender;

#pragma mark 分享
- (IBAction)shareButtonTapped:(UIButton *)sender;

#pragma mark - 锁屏按钮
- (IBAction)lockButtonClick:(UIButton *)sender;

#pragma mark - 自定义播放器需要的一些参数
/** 时间栏是否隐藏 */
@property (nonatomic,assign)BOOL isStatusBarHidden;

@property (nonatomic, assign) CGPoint curTickleStart;

//@property (nonatomic,assign)SwipeStyle swipeType;

//*快进view*/
@property (nonatomic,weak)ForwardBackView * forwardView;

@property (nonatomic,strong)NSURL *PrevMediaUrl;
@property (nonatomic, assign) BOOL isLockBtnEnable;//屏幕锁


/**
 *  v3是否小屏播放 - NO：展示锁屏按钮
 */
//@property (nonatomic,assign)BOOL isSmallPlayShow;

// ******//

@property (nonatomic, weak) id<TFVideoPlayerViewDelegate> delegate;


-(void)startActivityWithMsg:(NSString *)msg;

-(void)stopActivity;

-(void)setBtnEnableStatus:(BOOL)enable;

/**
 *  是否播放的是本地资源
 */
@property (nonatomic,assign)BOOL isPlayLocalFile;//我增加的字段，以便播放本地视频的时候视频不受打扰


//设置播放/暂停时按钮的状态， 播放 --> 暂停 :YES
- (void)setPlayButtonsSelected:(BOOL)selected ;

/**
 *  卸载播放器的View
 */
-(void)unInstallPlayerView;

@end






