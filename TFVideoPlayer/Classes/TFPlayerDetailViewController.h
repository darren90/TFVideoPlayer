//
//  TFPlayerDetailViewController.h
//  Pods
//
//  Created by Fengtf on 2017/10/8.
//

#import <UIKit/UIKit.h>

@interface TFPlayerDetailViewController : UIViewController

@property (nonatomic, strong) NSURL *playUrl;
//@property (nonatomic, copy) NSString *title;

//底下的数据
@property (nonatomic, strong) NSArray *recomms;
@property (nonatomic, assign) CGFloat rowHeight;

@end
