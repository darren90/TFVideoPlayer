//
//  TFPlayerView.m
//  Pods
//
//  Created by Fengtf on 2017/9/19.
//
//

#import "TFPlayerView.h"
#import "TFVideoPlayerView.h"
#import "Masonry.h"

@interface TFPlayerView ()<TFVideoPlayerDelegate, TFVideoPlayerViewDelegate, TFVideoPlayermDelegate>

//@property (nonatomic, strong) TFVideoPlayerView *playerView;

// TODO
@property (nonatomic, assign) BOOL                   isFullScreen;

@property (nonatomic, strong) UIView * playerFatherView;

@end

@implementation TFPlayerView

- (instancetype)init {
    if (self = [super init]) {
        [self initiaize];
    }
    return self;
}

- (void)initiaize{
    self.player = [[TFVideoPlayer alloc]init];
//    self.player.view.frame = self.bounds;
    self.backgroundColor = [UIColor blackColor];
    self.player.delegate = self;
    self.player.mDelegate = self;
    [self addSubview:self.player.view];
//    self.player.view.delegate = self;
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    // 监测设备方向
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onDeviceOrientationChange)
//                                                 name:UIDeviceOrientationDidChangeNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onStatusBarOrientationChange)
//                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
//                                               object:nil];
}

- (void)playStream:(NSURL*)url{
    [self.player playChangeStreamUrl:url title:self.topTitle seekToPos:0];
}

- (void)setPlayUrl:(NSURL *)playUrl {
    _playUrl = playUrl;
 
    if (CGRectEqualToRect(self.frame, [UIScreen mainScreen].bounds)) {
        self.player.showState = TFVideoPlayerFull;
    } else {
        self.player.showState = TFVideoPlayerSmall;
    }
    
    [self.player playChangeStreamUrl:playUrl title:self.topTitle seekToPos:0];
}


- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event{
    if (self.player.view.isLockBtnEnable) {
        return;
    }
    
//    switch (event) {
//        case TFVideoPlayerControlEventTapDone: {
//            [self.player pauseContent];
//            [self saveSeekDuration];
//            [self dismissViewControllerAnimated:YES completion:^{
//                [self unInstallPlayer];
//            }];
//        }
//            break;
//        case TFVideoPlayerControlEventPause: {
//            [self.player pauseContent];
//            
//        }
//            break;
//        default:
//            break;
//    }
}


- (void)playerOnCellView:(UIView *)cellView {
    self.playerFatherView = cellView;
    [self removeFromSuperview];
    [cellView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
}

- (void)playerOnCellView:(UIView *)cellView inView:(UIView *)inView {
    self.playerFatherView = cellView;
    [self removeFromSuperview];
    [inView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cellView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    [self layoutIfNeeded];
    
    //横屏
//    2017-10-08 21:07:36.307594+0800 RollClient[28221:2602665] -1-self fathe erView-frame: {{0, 0}, {667, 211}}
//    2017-10-08 21:07:36.307754+0800 RollClient[28221:2602665] -1-sele:frame: {{0, 0}, {667, 375}}
    
 // 竖屏
//    2017-10-08 21:08:02.911216+0800 RollClient[28221:2602665] -1-self fathe erView-frame: {{0, 0}, {375, 211}}
//    2017-10-08 21:08:02.911638+0800 RollClient[28221:2602665] -1-sele:frame: {{0, 0}, {375, 211}}
    
    NSLog(@"-1-self fathe erView-frame: %@   : %@", NSStringFromCGRect(self.playerFatherView.frame), self.superview);
    NSLog(@"-1-sele:frame: %@  : %@", NSStringFromCGRect(self.frame), self.superview);
//    if(self.frame.origin.y != 0) {
////        [self setNeedsLayout];
//        [self layoutIfNeeded];
//    }
}


- (void)fulllScrenAction {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (int)(UIInterfaceOrientation)orientation;

//    if (orientation == UIDeviceOrientationLandscapeRight) {
//        [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
//    } else {
//        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
//    }
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"fullScreenAction第3个旋转方向---电池栏在下");
            self.isFullScreen = YES;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"fullScreenAction第0个旋转方向---电池栏在上");
            self.isFullScreen = YES;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"fullScreenAction第2个旋转方向---电池栏在右");
            self.isFullScreen = NO;
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"fullScreenAction第1个旋转方向---电池栏在左");
            self.isFullScreen = NO;
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationUnknown:{
            NSLog(@"fullScreenAction第1个旋转方向---电池栏在左");;
            self.isFullScreen = YES;
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:{
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
    }
    
//    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
//    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0];
}

- (void)onDeviceOrientationChange {
    NSLog(@"----onDeviceOrientationChange--");
//    if(self.player.showState == TFVideoPlayerFull) return;
    if (!self.superview) return;
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (int)(UIInterfaceOrientation)orientation;
//    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
//    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0];
    
    //颠倒屏幕的情况不再处理
    if (interfaceOrientation == UIDeviceOrientationPortraitUpsideDown) return;
    
    [self removeFromSuperview];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.removeExisting = YES;
    }];

    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationUnknown) {
        self.player.showState = TFVideoPlayerSmall;
        //小屏幕
        NSLog(@"小屏显示");
        [self.playerFatherView addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
//            make.top.leading.bottom.trailing.equalTo(self.playerFatherView);
        }];
        self.frame = self.playerFatherView.bounds;
    } else {
        self.player.showState = TFVideoPlayerFull;
        //大屏
        NSLog(@"大屏显示");
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    self.transform = CGAffineTransformIdentity;
    self.transform = [self getTransformRotationAngle];
    // 开始旋转
    [UIView commitAnimations];

    NSLog(@"--fathe erView-frame: %@", NSStringFromCGRect(self.playerFatherView.frame));
    NSLog(@"--playerView-frame: %@", NSStringFromCGRect(self.frame));
}



#pragma mark 屏幕转屏相关

/**
 *  屏幕转屏
 *
 *  @param orientation 屏幕方向
 */
- (void)interfaceOrientation2:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
        // 设置横屏
        [self setOrientationLandscapeConstraint:orientation];
    } else if (orientation == UIInterfaceOrientationPortrait) {
        // 设置竖屏
//        [self setOrientationPortraitConstraint];
    }
}

/**
 *  设置横屏的约束
 */
- (void)setOrientationLandscapeConstraint:(UIInterfaceOrientation)orientation {
    [self toOrientation:orientation];
    self.isFullScreen = YES;
}

// 状态条变化通知（在前台播放才去处理）
- (void)onStatusBarOrientationChange {
//    [self onDeviceOrientationChange];
//    if (!self.didEnterBackground) {
        // 获取到当前状态条的方向
        UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
//        if (currentOrientation == UIInterfaceOrientationPortrait) {
////            [self setOrientationPortraitConstraint];
//            if (self.cellPlayerOnCenter) {
//                if ([self.scrollView isKindOfClass:[UITableView class]]) {
//                    UITableView *tableView = (UITableView *)self.scrollView;
//                    [tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
//
//                } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
//                    UICollectionView *collectionView = (UICollectionView *)self.scrollView;
//                    [collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//                }
//            }
//            [self.brightnessView removeFromSuperview];
//            [[UIApplication sharedApplication].keyWindow addSubview:self.brightnessView];
//            [self.brightnessView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.width.height.mas_equalTo(155);
//                make.leading.mas_equalTo((ScreenWidth-155)/2);
//                make.top.mas_equalTo((ScreenHeight-155)/2);
//            }];
//        } else {
//            if (currentOrientation == UIInterfaceOrientationLandscapeRight) {
//                [self toOrientation:UIInterfaceOrientationLandscapeRight];
//            } else if (currentOrientation == UIDeviceOrientationLandscapeLeft){
//                [self toOrientation:UIInterfaceOrientationLandscapeLeft];
//            }
//            [self.brightnessView removeFromSuperview];
//            [self addSubview:self.brightnessView];
//            [self.brightnessView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.center.mas_equalTo(self);
//                make.width.height.mas_equalTo(155);
//            }];
//
//        }
//    }
    NSLog(@"--onStatusBarOrientationChange--");
}


- (void)toOrientation:(UIInterfaceOrientation)orientation {
    // 获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) { return; }
    
    // 根据要旋转的方向,使用Masonry重新修改限制
    if (orientation != UIInterfaceOrientationPortrait) {//
        // 这个地方加判断是为了从全屏的一侧,直接到全屏的另一侧不用修改限制,否则会出错;
        if (currentOrientation == UIInterfaceOrientationPortrait) {
//            [self removeFromSuperview];
//            ZFBrightnessView *brightnessView = [ZFBrightnessView sharedBrightnessView];
//            [[UIApplication sharedApplication].keyWindow insertSubview:self belowSubview:brightnessView];
//            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.width.equalTo(@(ScreenHeight));
//                make.height.equalTo(@(ScreenWidth));
//                make.center.equalTo([UIApplication sharedApplication].keyWindow);
//            }];
        }
    }
    // iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    // 也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    // 获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    // 给你的播放视频的view视图设置旋转
    self.transform = CGAffineTransformIdentity;
    self.transform = [self getTransformRotationAngle];
    // 开始旋转
    [UIView commitAnimations];
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
    
    
//    // iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
//    // 也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
//    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
//    // 获取旋转状态条需要的时间:
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
//    // 给你的播放视频的view视图设置旋转
//    self.transform = CGAffineTransformIdentity;
//    self.transform = [self getTransformRotationAngle];
//    // 开始旋转
//    [UIView commitAnimations];

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


/**
 *  锁定屏幕方向按钮
 *
 *  @param sender UIButton
 */
- (void)lockScreenAction:(UIButton *)sender {
//    sender.selected             = !sender.selected;
//    self.isLocked               = sender.selected;
//    // 调用AppDelegate单例记录播放状态是否锁屏，在TabBarController设置哪些页面支持旋转
//    ZFPlayerShared.isLockScreen = sender.selected;
}

/**
 *  解锁屏幕方向锁定
 */
- (void)unLockTheScreen {
    // 调用AppDelegate单例记录播放状态是否锁屏
//    ZFPlayerShared.isLockScreen = NO;
//    [self.controlView zf_playerLockBtnState:NO];
//    self.isLocked = NO;
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}



@end
