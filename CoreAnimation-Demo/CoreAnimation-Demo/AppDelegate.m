//
//  AppDelegate.m
//  CoreAnimation-Demo
//
//  Created by luowei on 15/4/11.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <objc/runtime.h>

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
#import "ImplicitAnimationViewController.h"
#import "PresentationViewController.h"
#import "BasicAnimationViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "BezierAnimationViewController.h"
#import "TransitionViewController.h"
#import "StopAnimationViewController.h"
#import "ShapeLayerViewController.h"
#import "TextLayerViewController.h"
#import "TransformLayerViewController.h"
#import "GradientLayerViewController.h"
#import "ReplicatorLayerViewController.h"
#import "TiledLayerViewController.h"
#import "MediaTimingViewController.h"
#import "OpenDoorViewController.h"
#import "RelativeTimeViewController.h"
#import "MediaTimingFunctionViewController.h"
#import "ReboundBallViewController.h"
#import "DrawViewController.h"
#import "ChipmunkViewController.h"
#import "OptimizeViewController.h"
#import "ImageIOViewController.h"
#import "CollectionScrollViewController.h"
#import "CollectionTiledLayerViewController.h"
#import "PVRImageViewController.h"
#import "Matrix3DViewController.h"
#import "EmitterLayerViewController.h"
#import "EAGLLayerViewController.h"
#import "PlayerLayerViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    BOOL showToolBar;
}

@property(nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //添加tabBar
    UITableViewController *tableViewController1 = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tableViewController1.tableView.dataSource = self;
    tableViewController1.tableView.delegate = self;
    tableViewController1.title = @"图层(Layer)相关";
    self.navViewController1 = [[UINavigationController alloc] initWithRootViewController:tableViewController1];
    self.navViewController1.title = @"Layer";
    self.navViewController1.tabBarItem.title = @"图层(Layer)相关";
    self.navViewController1.tabBarItem.image = [UIImage imageNamed:@"aa"];

    UITableViewController *tableViewController2 = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tableViewController2.tableView.dataSource = self;
    tableViewController2.tableView.delegate = self;
    tableViewController2.title = @"动画(Annimation)相关";
    self.navViewController2 = [[UINavigationController alloc] initWithRootViewController:tableViewController2];
    self.navViewController2.title = @"Annimation";
    self.navViewController2.tabBarItem.title = @"动画(Annimation)相关";
    self.navViewController2.tabBarItem.image = [UIImage imageNamed:@"bb"];

    UITableViewController *tableViewController3 = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tableViewController3.tableView.dataSource = self;
    tableViewController3.tableView.delegate = self;
    tableViewController3.title = @"性能(Performance)相关";
    self.navViewController3 = [[UINavigationController alloc] initWithRootViewController:tableViewController3];
    self.navViewController3.title = @"Performance";
    self.navViewController3.tabBarItem.title = @"性能(Performance)相关";
    self.navViewController3.tabBarItem.image = [UIImage imageNamed:@"aa"];
    

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[self.navViewController1, self.navViewController2, self.navViewController3];
    self.tabBarController.delegate = self;
    self.window.rootViewController = self.tabBarController;

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


/*- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if(operation == UINavigationControllerOperationPop ){
        self.tabBarController.tabBar.hidden = NO;
    }
    return nil;
}*/

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"=======:%@", viewController.description);

}

#pragma mark UITabbarControllerDelegate Implements

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

    //给TabBar设置过渡动画
    //set up crossfade transition
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    //apply transition to tab bar controller's view
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 1.0f;
    return 32.0f;
}

#pragma mark UITableViewDataSource Implements

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (self.tabBarController.selectedIndex) {
        case 2: {
            return 6;
        }
        case 1: {
            return 13;
        }
        default: {
            return 21;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    switch (self.tabBarController.selectedIndex) {
        //性能相关
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([OptimizeViewController class])];
                    NSString *desc = @"TableView滚动优化";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 1: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ImageIOViewController class])];
                    NSString *desc = @"Collection及ImageIO操作";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 2: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([CollectionScrollViewController class])];
                    NSString *desc = @"自定义Collection横向滑动";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 3: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([CollectionTiledLayerViewController class])];
                    NSString *desc = @"CATiledLayer使用";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 4: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([PVRImageViewController class])];
                    NSString *desc = @"使用OpenGL加载PVR图像";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 5: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([Matrix3DViewController class])];
                    NSString *desc = @"3D阵列优化";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                default:
                    break;
            }
            break;
        }

            //动画相关
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([KeyFrameAnimationViewController class])];
                    NSString *desc = @"帧动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 1: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ImplicitAnimationViewController class])];
                    NSString *desc = @"隐式动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 2: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([PresentationViewController class])];
                    NSString *desc = @"呈现动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 3: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([BasicAnimationViewController class])];
                    NSString *desc = @"基础动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 4: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([BezierAnimationViewController class])];
                    NSString *desc = @"贝赛尔动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 5: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([TransitionViewController class])];
                    NSString *desc = @"过渡动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 6: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([StopAnimationViewController class])];
                    NSString *desc = @"动画控制";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 7: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([MediaTimingViewController class])];
                    NSString *desc = @"时间动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 8: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([OpenDoorViewController class])];
                    NSString *desc = @"开门动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 9: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([RelativeTimeViewController class])];
                    NSString *desc = @"相对时间动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 10: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([MediaTimingFunctionViewController class])];
                    NSString *desc = @"函数动画";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 11: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ReboundBallViewController class])];
                    NSString *desc = @"定义器模拟重力";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 12: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ChipmunkViewController class])];
                    NSString *desc = @"物理引擎Chipmunk";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                default:
                    break;
            }
            break;
        }

            //图层相关
        default: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ViewController class])];
                    NSString *desc = @"简单图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 1: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ContentRectViewController class])];
                    NSString *desc = @"拼合图片拆解";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 2: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ClickViewController class])];
                    NSString *desc = @"时钟";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 3: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([HitTestViewController class])];
                    NSString *desc = @"点触测试";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 4: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ShadowViewController class])];
                    NSString *desc = @"阴影图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 5: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([MaskViewController class])];
                    NSString *desc = @"遮罩图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 6: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([NearestViewController class])];
                    NSString *desc = @"图层滤镜Nearest模式";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 7: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([GroupOpacityViewController class])];
                    NSString *desc = @"栅格化图层实现组透明";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 8: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([TransformViewController class])];
                    NSString *desc = @"映射变换";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 9: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([Transform3dViewController class])];
                    NSString *desc = @"3D变换";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 10: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([Cube3dViewController class])];
                    NSString *desc = @"通过变换实现立方体";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 11: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([GradientLayerViewController class])];
                    NSString *desc = @"渐变图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 12: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ReplicatorLayerViewController class])];
                    NSString *desc = @"复制图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 13: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([ShapeLayerViewController class])];
                    NSString *desc = @"形状图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 14: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([TextLayerViewController class])];
                    NSString *desc = @"文本图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 15: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([TiledLayerViewController class])];
                    NSString *desc = @"瓦片图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 16: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([TransformLayerViewController class])];
                    NSString *desc = @"3D变换图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 17: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([EmitterLayerViewController class])];
                    NSString *desc = @"放射图层(粒子效果)";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 18: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([EAGLLayerViewController class])];
                    NSString *desc = @"EAGL图层(OpenGL绘制)";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 19: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([PlayerLayerViewController class])];
                    NSString *desc = @"视频播放图层";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                case 20: {
                    cell.textLabel.text = [NSString stringWithUTF8String:class_getName([DrawViewController class])];
                    NSString *desc = @"手写绘制";
                    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",desc,cell.textLabel.text];
                    break;
                }
                default:
                    break;
            }
            break;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    switch (self.tabBarController.selectedIndex) {
        //性能相关
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    OptimizeViewController *viewController = [OptimizeViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([OptimizeViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController3 pushViewController:viewController animated:YES];
                    break;
                }
                case 1: {
                    ImageIOViewController *viewController = [ImageIOViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ImageIOViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController3 pushViewController:viewController animated:YES];
                    break;
                }
                case 2: {
                    CollectionScrollViewController *viewController = [CollectionScrollViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([CollectionScrollViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController3 pushViewController:viewController animated:YES];
                    break;
                }
                case 3: {
                    CollectionTiledLayerViewController *viewController = [CollectionTiledLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([CollectionTiledLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController3 pushViewController:viewController animated:YES];
                    break;
                }
                case 4: {
                    PVRImageViewController *viewController = [PVRImageViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([PVRImageViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController3 pushViewController:viewController animated:YES];
                    break;
                }
                case 5: {
                    Matrix3DViewController *viewController = [Matrix3DViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([Matrix3DViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController3 pushViewController:viewController animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }

            //动画相关
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    KeyFrameAnimationViewController *viewController = [KeyFrameAnimationViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([KeyFrameAnimationViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 1: {
                    ImplicitAnimationViewController *viewController = [ImplicitAnimationViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ImplicitAnimationViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 2: {
                    PresentationViewController *viewController = [PresentationViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([PresentationViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 3: {
                    BasicAnimationViewController *viewController = [BasicAnimationViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([BasicAnimationViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 4: {
                    BezierAnimationViewController *viewController = [BezierAnimationViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([BezierAnimationViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 5: {
                    TransitionViewController *viewController = [TransitionViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([TransitionViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 6: {
                    StopAnimationViewController *viewController = [StopAnimationViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([StopAnimationViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 7: {
                    MediaTimingViewController *viewController = [MediaTimingViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([MediaTimingViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 8: {
                    OpenDoorViewController *viewController = [OpenDoorViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([OpenDoorViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 9: {
                    RelativeTimeViewController *viewController = [RelativeTimeViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([RelativeTimeViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 10: {
                    MediaTimingFunctionViewController *viewController = [MediaTimingFunctionViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([MediaTimingFunctionViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 11: {
                    ReboundBallViewController *viewController = [ReboundBallViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ReboundBallViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                case 12: {
                    ChipmunkViewController *viewController = [ChipmunkViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ChipmunkViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController2 pushViewController:viewController animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }

            //图层相关
        default: {
            switch (indexPath.row) {
                case 0: {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    ViewController *viewController = storyboard.instantiateInitialViewController;
                    viewController.title = [NSString stringWithUTF8String:class_getName([ViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 1: {
                    ContentRectViewController *viewController = [ContentRectViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ContentRectViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 2: {
                    ClickViewController *viewController = [ClickViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ClickViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 3: {
                    HitTestViewController *viewController = [HitTestViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([HitTestViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 4: {
                    ShadowViewController *viewController = [ShadowViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ShadowViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 5: {
                    MaskViewController *viewController = [MaskViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([MaskViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 6: {
                    NearestViewController *viewController = [NearestViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([NearestViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 7: {
                    GroupOpacityViewController *viewController = [GroupOpacityViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([GroupOpacityViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 8: {
                    TransformViewController *viewController = [TransformViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([TransformViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 9: {
                    Transform3dViewController *viewController = [Transform3dViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([Transform3dViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 10: {
                    Cube3dViewController *viewController = [Cube3dViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([Cube3dViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 11: {
                    GradientLayerViewController *viewController = [GradientLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([GradientLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 12: {
                    ReplicatorLayerViewController *viewController = [ReplicatorLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ReplicatorLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 13: {
                    ShapeLayerViewController *viewController = [ShapeLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([ShapeLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 14: {
                    TextLayerViewController *viewController = [TextLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([TextLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 15: {
                    TiledLayerViewController *viewController = [TiledLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([TiledLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 16: {
                    TransformLayerViewController *viewController = [TransformLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([TransformLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 17: {
                    EmitterLayerViewController *viewController = [EmitterLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([EmitterLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 18: {
                    EAGLLayerViewController *viewController = [EAGLLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([EAGLLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 19: {
                    PlayerLayerViewController *viewController = [PlayerLayerViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([PlayerLayerViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                case 20: {
                    DrawViewController *viewController = [DrawViewController new];
                    viewController.title = [NSString stringWithUTF8String:class_getName([DrawViewController class])];
                    [viewController setHidesBottomBarWhenPushed:YES];
                    [self.navViewController1 pushViewController:viewController animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
