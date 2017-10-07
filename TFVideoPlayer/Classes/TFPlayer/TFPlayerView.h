//
//  TFPlayerView.h
//  Pods
//
//  Created by Fengtf on 2017/9/19.
//
//

#import <UIKit/UIKit.h>
#import "TFVideoPlayer.h"

@interface TFPlayerView : UIView

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

- (void)playerOnCellView:(UIView *)cellView;

- (void)playerOnCellView:(UIView *)cellView inView:(UIView *)inView;

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end
