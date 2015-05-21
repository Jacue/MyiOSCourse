//
//  AppDelegate.m
//  AVPlayer-Demo
//
//  Created by luowei on 15/5/10.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "AppDelegate.h"
#import "AssetBrowserController.h"
#import "AssetTabBarController.h"


/* Media item url and time values are saved in the app preferences. */
static NSString *const AVPlayerDemoContentURLUserDefaultsKey = @"URL";
static NSString *const AVPlayerDemoContentTimeUserDefaultsKey = @"time";

typedef void (^AlertViewCompletionHandler)(void);

@interface AppDelegate () <AssetBrowserControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate> {
    UITabBarController *tabBarController;
}

@end

@implementation AppDelegate


- (UINavigationController *)assetBrowserControllerWithSourceType:(AssetBrowserSourceType)sourceType
                                                        delegate:(id <AssetBrowserControllerDelegate>)delegate {
    AssetBrowserController *browser = [[AssetBrowserController alloc] initWithSourceType:sourceType modalPresentation:NO];
    browser.delegate = delegate;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:browser];
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    [navController.navigationBar setTranslucent:YES];

    return navController;
}

- (UITabBarController *)tabbedAssetBrowserControllerWithSourceType:(AssetBrowserSourceType)sourceType
                                                          delegate:(id <AssetBrowserControllerDelegate>)delegate {
    UITabBarController *assetTabBarController = [[UITabBarController alloc] init];

    NSMutableArray *assetBrowserControllers = [NSMutableArray arrayWithCapacity:0];

    if (sourceType & AssetBrowserSourceTypeCameraRoll) {
        [assetBrowserControllers addObject:[self assetBrowserControllerWithSourceType:AssetBrowserSourceTypeCameraRoll delegate:delegate]];
    }
    if (sourceType & AssetBrowserSourceTypeFileSharing) {
        [assetBrowserControllers addObject:[self assetBrowserControllerWithSourceType:AssetBrowserSourceTypeFileSharing delegate:delegate]];
    }
    if (sourceType & AssetBrowserSourceTypeIPodLibrary) {
        [assetBrowserControllers addObject:[self assetBrowserControllerWithSourceType:AssetBrowserSourceTypeIPodLibrary delegate:delegate]];
    }

    assetTabBarController.viewControllers = assetBrowserControllers;

    return assetTabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.cachedAssetBrowser = [UINavigationController new];

    [self.window setRootViewController:self.cachedAssetBrowser];
    [self.window addSubview:self.cachedAssetBrowser.view];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Restore saved tab bar item from the defaults system.


    self->tabBarController = [self tabbedAssetBrowserControllerWithSourceType:AssetBrowserSourceTypeAll delegate:self];

    // The UITabBarItem 'tag' value is used to identify the saved tab bar item.
    NSInteger tabBarItemIndex = [defaults integerForKey:AVPlayerDemoPickerViewControllerSourceTypeUserDefaultsKey];
    NSArray *viewControllers = self->tabBarController.viewControllers;
    if (tabBarItemIndex < 0) {
        // If saved tab bar item does not match any existing item, then default to the first item.
        self->tabBarController.selectedIndex = 0;
    }
    else {
        NSInteger tempTabBarItemIndex = tabBarItemIndex;
        if (tempTabBarItemIndex > [viewControllers count]) {
            // If saved tab bar item does not match any existing item, then default to the first item.
            self->tabBarController.selectedIndex = 0;
        }
        else {
            self->tabBarController.selectedIndex =  tabBarItemIndex;
        }

    }

    // Add the tab bar controller's current view as a subview of the window
    [self.cachedAssetBrowser pushViewController:self->tabBarController animated:NO];

    // Restore saved media from the defaults system.
    NSURL *URL = [defaults URLForKey:AVPlayerDemoContentURLUserDefaultsKey];
    if (URL) {
        if (!self.playbackViewController) {
            self.playbackViewController = [[ViewController alloc] init];
        }

        [self.playbackViewController setUrl:URL];

        /* Restore saved media time value from defaults system. */
        [[self.playbackViewController player] seekToTime:CMTimeMakeWithSeconds([defaults doubleForKey:AVPlayerDemoContentTimeUserDefaultsKey], NSEC_PER_SEC)];

        [self.cachedAssetBrowser pushViewController:self.playbackViewController animated:NO];
    }

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];


    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/* When the app goes to the background, save the media url and time values
 to the application preferences. */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (self.playbackViewController) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSURL *URL = [self.playbackViewController url];

        if (URL) {
            NSTimeInterval time = CMTimeGetSeconds([[self.playbackViewController player] currentTime]);

            [defaults setURL:URL forKey:AVPlayerDemoContentURLUserDefaultsKey];
            [defaults setDouble:time forKey:AVPlayerDemoContentTimeUserDefaultsKey];
        }
        else {
            [defaults removeObjectForKey:AVPlayerDemoContentURLUserDefaultsKey];
            [defaults removeObjectForKey:AVPlayerDemoContentTimeUserDefaultsKey];
        }

        [defaults synchronize];
    }
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    if (self.playbackViewController && ![self.playbackViewController url]) {
        self.playbackViewController = nil;
    }
}


#pragma mark -
#pragma mark AssetBrowser Delegate

- (void)didPickURL:(AVURLAsset *)urlAsset {
    if (urlAsset) {
        if (!self.playbackViewController) {
            self.playbackViewController = [[ViewController alloc] init];
        }

        [self.playbackViewController setUrl:urlAsset.URL];

        [self.cachedAssetBrowser pushViewController:self.playbackViewController animated:YES];
    }
    else if (self.playbackViewController) {
        [self.playbackViewController setUrl:nil];
    }
}

- (void)assetBrowser:(AssetBrowserController *)assetBrowser didChooseItem:(AssetBrowserItem *)assetBrowserItem {
    AVURLAsset *asset = (AVURLAsset *) assetBrowserItem.asset;
    [self didPickURL:asset];
}


#pragma mark UINavigationControllerDelegate Implements

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /* Don't show the navigation bar when displaying the assets browser view */
    navigationController.navigationBarHidden = viewController == self->tabBarController;
}


@end