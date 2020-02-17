//
//  VideoPlayerViewController.m
//  iOSMultimedia
//
//  Created by qiyu on 2020/2/17.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController()


@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //非长期有效链接
    NSString *videoUrlString = @"https://f.video.weibocdn.com/000dUEwegx07B11mcpoP01041200Wcx50E010.mp4?label=mp4_hd&template=852x480.25.0&trans_finger=1621fcd5d40969f1c74e6b06e52fcd54&Expires=1581914746&ssig=P5EnNGTWll&KID=unistore,video&playerType=proto&";
    NSURL *url = [NSURL URLWithString:videoUrlString];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
}

@end
