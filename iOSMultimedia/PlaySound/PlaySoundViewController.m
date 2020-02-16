//
//  PlaySoundViewController.m
//  iOSMultimedia
//
//  Created by qiyu on 2020/2/14.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "PlaySoundViewController.h"
@import Masonry;
#import <AudioToolbox/AudioToolbox.h>


@interface PlaySoundViewController ()

@end

@implementation PlaySoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *soundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound"]];
    soundImage.contentMode =  UIViewContentModeScaleAspectFit;
    soundImage.userInteractionEnabled = YES;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundImageTapAction)];
    [soundImage addGestureRecognizer:tap];
    [self.view addSubview:soundImage];
    [soundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

- (void)soundImageTapAction {
    //加载音效
    SystemSoundID soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cartoon Flute Broken.wav" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID); //C语言，存在类型转换
    //播放音效
    AudioServicesPlaySystemSound(soundID);
    // 静音时可震动提醒
    // AudioServicesPlayAlertSound(SystemSoundID inSystemSoundID);
}


@end
