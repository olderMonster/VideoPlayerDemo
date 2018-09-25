//
//  TableViewCell.m
//  VideoPlayerDemo
//
//  Created by 印聪 on 2018/9/19.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "TableViewCell.h"
#import <JPVideoPlayer/JPVideoPlayerKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface TableViewCell()

@property (nonatomic , strong)UIImageView *iconImageView;
@property (nonatomic , strong)UIButton *playButton;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.playButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.frame = self.contentView.bounds;
    
    self.playButton.bounds = CGRectMake(0, 0, 40, 30);
    self.playButton.center = self.iconImageView.center;
}

- (void)playAction{
    
    self.playButton.selected = !self.playButton.selected;
    
    if (self.playButton.selected) {
        [self.iconImageView jp_playVideoWithURL:[NSURL URLWithString:@"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=127731&resourceType=video&editionType=default&source=aliyun&f=iphone&u=&vc=0"]];
    }else{
        [self.iconImageView jp_pause];
    }
    
  
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.kaiyanapp.com/5d296f5ac8e987c7930c9ab9aec08d73.jpeg?imageMogr2/quality/60/format/jpg"]];
    }
    return _iconImageView;
}

- (UIButton *)playButton{
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"play" forState:UIControlStateNormal];
        [_playButton setTitle:@"pause" forState:UIControlStateSelected];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

@end
