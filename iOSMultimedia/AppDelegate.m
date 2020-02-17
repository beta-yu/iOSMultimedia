//
//  AppDelegate.m
//  iOSMultimedia
//
//  Created by qiyu on 2020/2/11.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[ViewController alloc] initWithRootViewController:[[TableViewController alloc] initWithStyle:UITableViewStyleGrouped]];
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
