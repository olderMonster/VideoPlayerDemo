//
//  OMPlayerView.m
//  VideoPlayerDemo
//
//  Created by 印聪 on 2018/9/25.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "OMPlayerView.h"

#import <AVFoundation/AVFoundation.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface OMPlayerView()

@property (nonatomic , strong)UIImageView *coverImageView;
@property (nonatomic , strong)UIButton *playButton;
@property (nonatomic , strong)UIView *bottomView;
@property (nonatomic , strong)UIButton *fullScreenButton;

@property (nonatomic , strong)AVPlayerItem *playerItem;
@property (nonatomic , strong)AVPlayer *player;
@property (nonatomic , strong)AVPlayerLayer *playerLayer;


@property (nonatomic , strong)UIView *v_superView;
@property (nonatomic , assign)CGRect beforeFullScreenFrame;

@property (nonatomic , assign , readwrite)OMPlayerViewStatus status;

@end

@implementation OMPlayerView

- (instancetype)init{
    self = [super init];
    if (self) {
        _status = OMPlayerViewStatusNone;
        _autoPlay = YES;
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.coverImageView];
        [self addSubview:self.playButton];
        [self addSubview:self.bottomView];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.coverImageView.frame = self.bounds;
    
    self.playButton.bounds = CGRectMake(0, 0, 30, 30);
    self.playButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    self.bottomView.frame = CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40);
    self.fullScreenButton.bounds = CGRectMake(0, 0, 25, 25);
    self.fullScreenButton.center = CGPointMake(self.bottomView.bounds.size.width - 10 - self.fullScreenButton.bounds.size.width * 0.5, self.bottomView.bounds.size.height * 0.5);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.playButton.hidden) {
        self.playButton.hidden = NO;
        self.bottomView.hidden = NO;
    }
}


#pragma mark -- public method
- (void)play{
    if (self.status == OMPlayerViewStatusReadyToPlay || self.status == OMPlayerViewStatusPause) {
        [self.player play];
        self.status = OMPlayerViewStatusPlaying;
        self.playButton.selected = YES;
        self.coverImageView.hidden = YES;
        [UIView animateWithDuration:1.0 animations:^{
            self.playButton.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.playButton.hidden = YES;
            self.playButton.alpha = 1.0;
            self.bottomView.hidden = YES;
        }];
    }else if (self.status == OMPlayerViewStatusPlaying){
        [self.player pause];
        self.status = OMPlayerViewStatusPause;
        self.playButton.selected = NO;
    }
}

- (void)pause{
    if (self.status == OMPlayerViewStatusPlaying) {
        [self.player pause];
        self.status = OMPlayerViewStatusPause;
        self.playButton.selected = NO;
    }
}


#pragma mark -- event response
- (void)fullScreenButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shouldFullScreen:)]) {
        [self.delegate shouldFullScreen:self];
    }else{
        
        
//        if (CGRectEqualToRect(self.beforeFullScreenFrame, CGRectZero) && self.v_superView == nil) {
//            self.beforeFullScreenFrame = self.frame;
//            self.v_superView = self.superview;
//            
//            UIWindow *window = [UIApplication sharedApplication].delegate.window;
//            [UIView animateWithDuration:1.0 animations:^{
//                [window addSubview:self];
//                self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
//                self.transform = CGAffineTransformMakeRotation(M_PI_2);
//            }];
//        }else{
//            
//            [UIView animateWithDuration:1.0 animations:^{
//                [self.v_superView addSubview:self];
//                self.frame = self.beforeFullScreenFrame;
//                self.transform = CGAffineTransformIdentity;
//            }];
//            
//        }
        
        
    }
}


#pragma mark -- observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isEqual:self.playerItem]) {
        if ([keyPath isEqualToString:@"status"]) {
            if (self.playerItem.status == AVPlayerStatusReadyToPlay) {
                self.status = OMPlayerViewStatusReadyToPlay;
                
                if (self.autoPlay) {
                    [self play];
                }
                
            }
            if (self.playerItem.status == AVPlayerStatusFailed) {
                self.status = OMPlayerViewStatusLoadFailed;
            }
            if (self.playerItem.status == AVPlayerStatusUnknown) {
                self.status = OMPlayerViewStatusLoadFailed;
            }
        }
    }
}



#pragma mark -- getters and setters
- (UIImageView *)coverImageView{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.backgroundColor = [UIColor whiteColor];
        _coverImageView.hidden = YES;
    }
    return _coverImageView;
}


- (UIButton *)playButton{
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"video_play_btn"] forState:UIControlStateNormal];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"video_pause_btn"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [_bottomView addSubview:self.fullScreenButton];
    }
    return _bottomView;
}

- (UIButton *)fullScreenButton{
    if (_fullScreenButton == nil) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setBackgroundImage:[UIImage imageNamed:@"video_fullscreen_btn"] forState:UIControlStateNormal];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

- (void)setCover_url:(NSString *)cover_url{
    _cover_url = cover_url;
    
    self.coverImageView.hidden = NO;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_cover_url]];
}

- (void)setUrl:(NSString *)url{
    _url = url;
    
    if (_url == nil || _url.lowercaseString <= 0) {
        return;
    }
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.url]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    layer.frame = self.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.playerItem = item;
    self.player = player;
    self.playerLayer = layer;
}


@end
