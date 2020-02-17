//
//  VideoPlayerTableViewController.m
//  iOSMultimedia
//
//  Created by qiyu on 2020/2/17.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "VideoPlayerTableViewController.h"
#import "VideoPlayerViewController.h"
#import "VideoAVPlayerViewController.h"

@interface VideoPlayerTableViewController ()

@property (nonatomic, copy) NSArray *titles;

@end

@implementation VideoPlayerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"reuseIdentifier"];
    self.titles = @[@"AVPlayerViewController", @"AVPlayer"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            VideoPlayerViewController *videoPlayerVC = [[VideoPlayerViewController alloc] init];
            [self.navigationController pushViewController:videoPlayerVC animated:YES];
            break;
        }
        case 1: {
            VideoAVPlayerViewController *videoAVPlayerVC = [[VideoAVPlayerViewController alloc] init];
            [self.navigationController pushViewController:videoAVPlayerVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
