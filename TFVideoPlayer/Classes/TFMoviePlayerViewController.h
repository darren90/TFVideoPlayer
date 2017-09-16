//
//  TFVideoPlayerViewController.h
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFVideoPlayer.h"

@interface TFMoviePlayerViewController : UIViewController
@property (nonatomic, strong) TFVideoPlayer* player;



@property (nonatomic,copy)NSURL * playUrl;

/**
 *  小屏播放器要用到
 *
 *  @param url 播放地址
 */
- (void)playStream:(NSURL*)url;


#pragma mark - 卸载播放器
-(void)unInstallPlayer;


//新字段

/**
 *  必传参数，- 集ID - 也即seriesId
 */
@property (nonatomic,copy)NSString * movieId;

/**
 *  标题 （没有拼接集数的title）
 */
@property (nonatomic,copy)NSString * topTitle;

/**
 *  分享的时候的 封面url 必传，且是网页地址
 */
@property (nonatomic,copy)NSString * coverUrl;


/**
 *  播放地址本地已下载的文件，只针对mp4文件(没有后缀的文件名)
 */
@property (nonatomic,copy)NSString * playLocalUrl;


@end
