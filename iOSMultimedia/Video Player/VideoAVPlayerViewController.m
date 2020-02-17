//
//  VideoAVPlayerViewController.m
//  iOSMultimedia
//
//  Created by qiyu on 2020/2/17.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "VideoAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoAVPlayerViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation VideoAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *urlString = @"https://f.video.weibocdn.com/000dUEwegx07B11mcpoP01041200Wcx50E010.mp4?label=mp4_hd&template=852x480.25.0&trans_finger=1621fcd5d40969f1c74e6b06e52fcd54&Expires=1581917452&ssig=na%2FfoFUbF1&KID=unistore,video&playerType=proto&";
    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    layer.frame = CGRectMake(0, 200, screenWidth, screenWidth / 16 * 9);
    
    [self.view.layer addSublayer:layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.player play];
}



@end
