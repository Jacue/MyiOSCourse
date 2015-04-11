//
//  AppDelegate.m
//  CoreAnimation-Demo
//
//  Created by luowei on 15/4/11.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ContentRectViewController.h"
#import "ClickViewController.h"
#import "HitTestViewController.h"
#import "ShadowViewController.h"
#import "MaskViewController.h"
#import "NearestViewController.h"
#import "GroupOpacityViewController.h"
#import "TransformViewController.h"
#import "Transform3dViewController.h"
#import "Cube3dViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    self.window.rootViewController = storyboard.instantiateInitialViewController;

//    self.window.rootViewController = [ContentRectViewController new];
//    self.window.rootViewController = [ClickViewController new];
//    self.window.rootViewController = [HitTestViewController new];
//    self.window.rootViewController = [ShadowViewController new];
//    self.window.rootViewController = [MaskViewController new];
//    self.window.rootViewController = [NearestViewController new];
//    self.window.rootViewController = [GroupOpacityViewController new];
//    self.window.rootViewController = [TransformViewController new];
//    self.window.rootViewController = [Transform3dViewController new];
    self.window.rootViewController = [Cube3dViewController new];


    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
