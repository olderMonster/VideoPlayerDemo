//
//  ViewController.m
//  VideoPlayerDemo
//
//  Created by 印聪 on 2018/9/19.
//  Copyright © 2018年 印聪. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"
#import "OMPlayerView.h"

@interface ViewController ()<UITableViewDataSource>

@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)OMPlayerView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.playerView];
    
    self.playerView.cover_url = @"http://img.kaiyanapp.com/c3f98c471aa9e7aac1f2c3c9e16f69af.jpeg?imageMogr2/quality/60/format/jpg";
    self.playerView.url = @"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=127731&resourceType=video&editionType=default&source=aliyun&f=iphone&u=&vc=0";
    [self.playerView play];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}



- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 200;
    }
    return _tableView;
}

- (OMPlayerView *)playerView{
    if (_playerView == nil) {
        _playerView = [[OMPlayerView alloc] init];
        _playerView.frame = CGRectMake(0, 40, self.view.bounds.size.width, 250);
        _playerView.autoPlay = NO;
    }
    return _playerView;
}

@end
