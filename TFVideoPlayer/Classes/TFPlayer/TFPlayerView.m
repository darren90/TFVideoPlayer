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

@interface TFPlayerView ()<TFVideoPlayerDelegate,TFVideoPlayerViewDelegate>

@property (nonatomic, strong) TFVideoPlayerView *playerView;

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
    self.player.delegate = self;
    [self addSubview:self.player.view];
    self.playerView.delegate = self;
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}

- (void)playStream:(NSURL*)url{
    [self.player playChangeStreamUrl:url title:self.topTitle seekToPos:0];
}

- (void)setPlayUrl:(NSURL *)playUrl {
    _playUrl = playUrl;
 
    if (CGRectEqualToRect(self.frame, [UIScreen mainScreen].bounds)) {
        self.player.showState = TFVideoPlayerFull;
    } else {
        self.player.showState = TFVideoPlayerCell;
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


- (void)fulllScrenAction {

    
}




@end
