//
//  TFPlayerController.h
//  VideoPlayer
//
//  Created by Fengtf on 16/6/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFPlayer.h"

@interface TFPlayerController : UIViewController

@property (nonatomic, strong) TFVideoPlayer* player;

@property (nonatomic,copy)NSURL * playUrl;

/**
 *  小屏播放器要用到
 *
 *  @param url 播放地址
 */
- (void)playStream:(NSURL*)url;
//-(void)playChangeStreamUrl:(NSURL *)url;


#pragma mark - 卸载播放器
-(void)unInstallPlayer;

@end
