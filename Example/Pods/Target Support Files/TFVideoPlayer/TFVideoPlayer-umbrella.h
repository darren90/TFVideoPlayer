#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BrightnessView.h"
#import "ForwardBackView.h"
#import "TFPlayer.h"
#import "TFPlayerTools.h"
#import "TFVideoPlayer.h"
#import "TFVideoPlayerView.h"
#import "TFVSegmentSlider.h"
#import "UISlider+VDTrackHeight.h"
#import "TFPlayerController.h"
#import "VDefines.h"
#import "Vitamio.h"
#import "VMediaExtracter.h"
#import "VMediaExtracterDef.h"
#import "VMediaPlayer.h"
#import "VMediaPlayerDelegate.h"
#import "VPlayerManageDef.h"
#import "VSingleton.h"

FOUNDATION_EXPORT double TFVideoPlayerVersionNumber;
FOUNDATION_EXPORT const unsigned char TFVideoPlayerVersionString[];

