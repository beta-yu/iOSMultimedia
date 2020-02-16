//
//  MusicPlayerViewController.m
//  iOSMultimedia
//
//  Created by qiyu on 2020/2/14.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "MusicPlayerViewController.h"
@import Masonry;
@import MBProgressHUD;
#import <AVFoundation/AVFoundation.h>
#import "Common.h"

@interface MusicPlayerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, assign) NSUInteger lastSelectedIndex;
@property (nonatomic, strong) AVAudioPlayer *localMusicPlayer;
@property (nonatomic, assign) BOOL paused;

@property (nonatomic, strong) AVPlayer *onlineMusicPlayer;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, copy) NSMutableArray<AVPlayerItem *> *onlinePlayerItems;

@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = mRGBColor(244, 245, 245);
    
    self.progressSlider = [[UISlider alloc] init];
    [self.view addSubview:self.progressSlider];
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading).offset(5);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-5);
        make.top.mas_equalTo(self.view.mas_centerY);
    }];
    
    
    self.titles = @[@"Local", @"Online"];
    self.lastSelectedIndex = self.titles.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
//    cell.tintColor = mRGBColor(126, 211, 33); //这里会改变对勾的颜色，关于tintColor有待研究
    cell.textLabel.text = self.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Music Player";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = mRGBColor(153, 153, 153);
    [header addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@16);
        make.bottom.equalTo(@-12);
    }];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lastSelectedIndex < self.titles.count) {
        UITableViewCell *lastCheckMarkCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelectedIndex inSection:0]];
        lastCheckMarkCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.lastSelectedIndex = indexPath.row;
//    选中后不变色，可在创建cell使用cell.selectionStyle = UITableViewCellSelectionStyleNone;或在这里使用：
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //Local
    if (indexPath.row == 0) {
        [self playLocalMusic];
    } else { //Online
        [self playOnlineMusic];
    }
}

# pragma mark local music play

- (void)playLocalMusic {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Timofiy_Starenkov_-_The_Journey.mp3" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    self.localMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (!error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

        // Set the determinate mode to show task progress.
        hud.mode = MBProgressHUDModeDeterminate;
        hud.label.text = @"Playing...";

        // Configure the button.
        [hud.button setTitle:@"Pause" forState:UIControlStateNormal];
        [hud.button addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something useful in the background and update the HUD periodically.
            [self doSomeWorkWithProgress];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        });
    } else {
        NSLog(@"%@", error);
    }
}

- (void)doSomeWorkWithProgress {
    [self.localMusicPlayer prepareToPlay];
    [self.localMusicPlayer play];
    self.paused = NO;
    float progress = 0.0f;
    float span = 1.0f / ((float)self.localMusicPlayer.duration * 2);
    while (progress < 1.0f) {
        if (self.paused) break;
        progress += span;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
        });
        usleep(500000);
    }
}

- (void)pause {
    [self.localMusicPlayer stop];
    self.paused = YES;
}

#pragma mark online music play

- (void)playOnlineMusic {
    NSString *mp3FileUrlString = @"http://m8.music.126.net/20200216213940/be985d435c1c6a2282c0bf1a0a0d5f2e/ymusic/986b/160c/0f55/8dd6b5c8668ebfba391f4f078db7e087.mp3";
    
    NSURL *url = [NSURL URLWithString:mp3FileUrlString];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [self.onlinePlayerItems addObject:item];
    
    self.onlineMusicPlayer = [AVPlayer playerWithPlayerItem:item];
    
    [self.onlineMusicPlayer play];
    
//    NSLog(@"%@", self.onlineMusicPlayer.error);
    [self doSomeWorkWithOnlineMusicPlayWithIndex:0];
}

- (void)doSomeWorkWithOnlineMusicPlayWithIndex:(NSInteger)index {
    AVPlayerItem *currentItem = self.onlinePlayerItems[index];
    
    NSLog(@"%lld -- %d", currentItem.duration.value, currentItem.duration.timescale);
//    self.progressSlider.maximumValue = CMTimeGetSeconds(currentItem.duration);
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.progressSlider.value += 0.5;
    }];
}

@end
