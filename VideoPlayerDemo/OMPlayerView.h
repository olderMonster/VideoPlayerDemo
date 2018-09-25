//
//  OMPlayerView.h
//  VideoPlayerDemo
//
//  Created by 印聪 on 2018/9/25.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OMPlayerView;
NS_ASSUME_NONNULL_BEGIN


/**
 @enum OMPlayerViewStatus
 @abstract
    播放状态,当前视频的加载情况

 @constant     OMPlayerViewStatusNone
 初始状态，已经设置了url但是没有调用play方法时为这个状态
 
 @constant     OMPlayerViewStatusLoading
 正在加载视频
 
 @constant     OMPlayerViewStatusLoadFailed
 加载失败

 @constant     OMPlayerViewStatusReadyToPlay
 加载完整，准备播放
 
 @constant     OMPlayerViewStatusPlaying
 正在播放
 
 @constant     OMPlayerViewStatusPause
 暂停中
 
 @constant     OMPlayerViewStatusPlayFinished
 播放完成
 */
typedef NS_ENUM(NSInteger , OMPlayerViewStatus) {
    OMPlayerViewStatusNone = 0,          //初始状态，没有调用play方法时为这个状态
    OMPlayerViewStatusLoading = 1,       //正在加载视频
    OMPlayerViewStatusLoadFailed = 2,    //加载失败
    OMPlayerViewStatusReadyToPlay = 3,   //加载完整，准备播放
    OMPlayerViewStatusPlaying = 4,       //正在播放
    OMPlayerViewStatusPause = 5,         //暂停中
    OMPlayerViewStatusPlayFinished = 6   //播放完成
};


@protocol OMPlayerViewDelegate <NSObject>

- (void)shouldFullScreen:(OMPlayerView *)playerView;

@end


@interface OMPlayerView : UIView


/**
 视频播放的url
 */
@property (nonatomic , strong)NSString *url;



/**
 状态
 */
@property (nonatomic , assign , readonly)OMPlayerViewStatus status;


/**
 视频封面图片.不设置该属性即显示视频的第一帧
 */
@property (nonatomic , strong)NSString *cover_url;


/**
 自动播放,默认为YES
 */
@property (nonatomic , assign)BOOL autoPlay;


@property (nonatomic , weak)id<OMPlayerViewDelegate>delegate;


/**
 播放视频
 */
- (void)play;


/**
 暂停视频
 */
- (void)pause;

@end

NS_ASSUME_NONNULL_END
